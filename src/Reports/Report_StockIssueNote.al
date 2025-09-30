report 50073 StockIssueNote
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/StockIssueNoteReport_v1.rdl';
    Caption = 'Stock Issue Note';
    ApplicationArea = Suite;
    UsageCategory = Documents;
    WordMergeDataItem = "Transfer Shipment Header";

    dataset
    {
        dataitem("Transfer Shipment Header"; "Transfer Shipment Header")
        {
            column(PrintName; CompanyInfo."Print Name")
            {
            }
            column(CompanyAddress; CompanyInfo."Address")
            {
            }
            column(CompanyPostcode; CompanyInfo."Post Code")
            {
            }
            column(CompanyCity; CompanyInfo."City")
            {
            }
            column(CompanyState; CompanyCounty)
            {
            }
            column(CompanyCountry; CompanyCountry)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(CompanyInfoFax; CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfoPhoneNo; CompanyInfo."Phone No.")
            {
            }
            column(CompanyInfoEmail; CompanyInfo."E-Mail")
            {
            }
            column(CompanyInfoHomePage; CompanyInfo."Home Page")
            {
            }
            column(CompanyInfoVATRegNo; CompanyInfo."ADY E-INV SST Reg No.")
            {
            }
            column(CompanyInfoBusinessRegistrationNo; CompanyInfo."Registration No.")
            {
            }
            column(CompanyInfoGiroNo; CompanyInfo."Giro No.")
            {
            }
            column(CompanyInfoBankName; CompanyInfo."Bank Name")
            {
            }
            column(CompanyInfoBankAccountNo; CompanyInfo."Bank Account No.")
            {
            }
            column(CompanyLogo; CompanyInfo."Picture")
            {
            }
            column(CompanyPicture1; CompanyInfo."Company Logo 1")
            {
            }
            column(CompanyPicture2; CompanyInfo."Company Logo 2")
            {
            }
            column(CompanyPicture3; CompanyInfo."Company Logo 3")
            {
            }
            column(FromDepartment; FromDepartment)
            {
            }
            column(ToDepartment; ToDepartment)
            {
            }
            column(StockTRfNo; "Transfer Order No.")
            {
            }
            column(No; "No.")
            {
            }
            column(StockTrfDate; Format("Posting Date"))
            {
            }
            dataitem("Transfer Shipment Line"; "Transfer Shipment Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Transfer Shipment Header";
                column(ItemNo; "Item No.")
                {
                }
                column(Description; "Description")
                {
                }
                column(Quantity; Quantity)
                {
                }
                column(RequestedQty; RequestedQty)
                {
                }
                column(UOM; "Unit of Measure Code")
                {
                }
                column(TransferFromCode; "Transfer-from Code")
                {
                }
                column(TransferFromDescription; TransferFromDescription)
                {
                }
                column(TransferToCode; "Transfer-to Code")
                {
                }
                column(TransferToDescription; TransferToDescription)
                {
                }
                column(ReceivedQty; ReceivedQty)
                {
                }
                column(Comments; '')
                {
                }
                trigger OnAfterGetRecord()
                var
                    LocationRec: Record Location;
                    TransferReceiptLine: Record "Transfer Receipt Line";
                    TransferLine: Record "Transfer Line";
                    TransferShipmentHeader: Record "Transfer Shipment Header";
                    TransferShipmentLine: Record "Transfer Shipment Line";
                begin
                    Quantity := 0;
                    RequestedQty := 0;
                    ReceivedQty := 0;
                    if LocationRec.Get("Transfer-from Code") then
                        TransferFromDescription := LocationRec.Name;
                    if LocationRec.Get("Transfer-to Code") then
                        TransferToDescription := LocationRec.Name;
                    TransferReceiptLine.SetRange("Transfer Order No.", "Transfer Order No.");
                    if (TransferReceiptLine.FindSet()) then begin
                        repeat
                            ReceivedQty += TransferReceiptLine.Quantity;
                        until TransferReceiptLine.Next() = 0;
                    end;
                    TransferLine.Reset();
                    TransferLine.SetRange("Document No.", "Transfer Order No.");
                    TransferLine.SetRange("Line No.", "Trans. Order Line No.");
                    if (TransferLine.FindSet()) then begin
                        repeat
                            RequestedQty += TransferLine."Outstanding Quantity";
                        until TransferLine.Next() = 0;
                    end
                    else
                        TransferShipmentHeader.Reset();
                    TransferShipmentHeader.SetRange("Transfer Order No.", "Transfer Shipment Line"."Transfer Order No.");
                    if (TransferShipmentHeader.FindSet()) then
                        repeat
                            TransferShipmentLine.Reset();
                            TransferShipmentLine.SetRange("Document No.", TransferShipmentHeader."No.");
                            if TransferShipmentLine.FindSet() then
                                repeat
                                    RequestedQty += TransferShipmentLine."Quantity";
                                until TransferShipmentLine.Next() = 0
                            else
                                RequestedQty += "Transfer Shipment Line".Quantity;
                        until TransferShipmentHeader.Next() = 0;
                    TransferShipmentHeader.Reset();
                    TransferShipmentHeader.SetRange("Transfer Order No.", "Transfer Shipment Line"."Transfer Order No.");
                    if (TransferShipmentHeader.FindSet()) then
                        repeat
                            TransferShipmentLine.Reset();
                            TransferShipmentLine.SetRange("Document No.", TransferShipmentHeader."No.");
                            if TransferShipmentLine.FindSet() then
                                repeat
                                    Quantity += TransferShipmentLine."Quantity";
                                until TransferShipmentLine.Next() = 0
                            else
                                Quantity += "Transfer Shipment Line".Quantity;
                        until TransferShipmentHeader.Next() = 0;
                end;
            }
            trigger OnAfterGetRecord()
            var
                FromLocation: Record Location;
                ToLocation: Record Location;
            begin
                if FromLocation.Get("Transfer-from Code") then
                    FromDepartment := FromLocation.Name;

                if ToLocation.Get("Transfer-to Code") then
                    ToDepartment := ToLocation.Name;
            end;

            trigger OnPreDataItem()
            var
                CountryRegion: Record "Country/Region";
                County: Record County;
            begin
                CompanyInfo.Get();
                FormatAddr.Company(CompanyAddr, CompanyInfo);
                begin

                    if CountryRegion.Get(CompanyInfo."Country/Region Code") then
                        CompanyCountry := CountryRegion.Name;
                    if County.Get(CompanyInfo."County") then
                        CompanyCounty := County."Description";
                end;
                GLSetup.Get();
            end;
        }
    }
    trigger OnInitReport()
    begin
        CompanyInfo.SetAutoCalcFields(Picture);
        CompanyInfo.SetAutoCalcFields("Company Logo 1");
        CompanyInfo.SetAutoCalcFields("Company Logo 2");
        CompanyInfo.SetAutoCalcFields("Company Logo 3");
    end;

    var
        Quantity: Decimal;
        RequestedQty: Decimal;
        ReceivedQty: Decimal;
        CompanyCounty: Text;
        CompanyCountry: Text;
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        FormatAddr: Codeunit "Format Address";
        ReportTitle: Text[30];
        CompanyAddr: array[8] of Text[100];
        TransferFromDescription: Text;
        TransferToDescription: Text;
        FromDepartment: Text;
        ToDepartment: Text;
}