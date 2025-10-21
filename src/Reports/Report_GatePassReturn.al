report 50075 GatePassReportv2
{
    DefaultLayout = RDLC;
    //RDLCLayout = './src/Reports/Layouts/GatePassReport_v1.rdl';
    RDLCLayout = './src/Reports/Layouts/GatePassReportReturn.rdl';
    Caption = 'Gate Pass (Return)';
    ApplicationArea = Suite;
    UsageCategory = Documents;
    WordMergeDataItem = "Transfer Header";

    dataset
    {
        dataitem("Transfer Header"; "Transfer Header")
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
            column(No; "No.")
            {
            }
            column(PostingDate; Format("Posting Date"))
            {
            }
            column(DriverName; "Driver Name")
            {
            }
            column(VehicleNo; "Vehicle No")
            {
            }
            dataitem("Transfer Line"; "Transfer Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Transfer Header";
                DataItemTableView = sorting("Document No.", "Line No.") where("Quantity Shipped" = const(0), "Quantity Received" = const(0));

                column(ItemNo; "Item No.")
                {
                }
                column(Date; Format("Shipment Date"))
                {
                }
                column(Issue; '')
                {
                }
                column(Status; '')
                {
                }
                column(Description; "Description")
                {
                }
                column(Quantity; "Quantity")
                {
                }
                column(UOM; "Unit of Measure Code")
                {
                }
                column(TakenBy; '')
                {
                }
                column(NIRC; '')
                {
                }
                column(Remarks; '')
                {
                }
            }
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
        CompanyCounty: Text;
        CompanyCountry: Text;
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        FormatAddr: Codeunit "Format Address";
        ReportTitle: Text[30];
        CompanyAddr: array[8] of Text[100];
}