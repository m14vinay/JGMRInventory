report 50074 TransferOrderReport
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/StockTransferDetailReport_v1.rdl';
    Caption = 'Transfer Order';
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
            column(CompanyInfoVATRegNo; CompanyInfo."VAT Registration No.")
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
            column(StockTRfNo; "No.")
            {
            }
            column(StockTrfDate; Format("Posting Date"))
            {
            }
            dataitem("Transfer Line"; "Transfer Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemLinkReference = "Transfer Header";

                column(ItemNo; "Item No.")
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
                column(TransferFromCode; "Transfer-from Code")
                {
                }
                column(TransferFromDescription; TransferFromDescription)
                {
                }
                column(Comments; '')
                {
                }
                trigger OnAfterGetRecord()
                var
                    LocationRec: Record Location;
                begin
                    if LocationRec.Get("Transfer-from Code") then
                        TransferFromDescription := LocationRec.Name;
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
        CompanyCounty: Text;
        CompanyCountry: Text;
        CompanyInfo: Record "Company Information";
        GLSetup: Record "General Ledger Setup";
        FormatAddr: Codeunit "Format Address";
        ReportTitle: Text[30];
        CompanyAddr: array[8] of Text[100];
        TransferFromDescription: Text;
        FromDepartment: Text;
        ToDepartment: Text;
}