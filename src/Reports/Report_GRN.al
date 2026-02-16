report 50079 GRNReport
{
    DefaultLayout = RDLC;
    RDLCLayout = './src/Reports/Layouts/GRNReport.rdl';
    Caption = 'Goods Receipt Note Summary List';
    ApplicationArea = Suite;
    UsageCategory = Documents;
    WordMergeDataItem = "Purchase Receipt Header";

    dataset
    {
        dataitem("Purchase Receipt Header"; "Purch. Rcpt. Header")
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
            column(Pay_to_Vendor_No_; "Pay-to Vendor No.")
            {
            }
            column(PurchaseOrder; 'Purchase Order')
            {
            }
            column(Order_No_; "Order No.")
            {
            }
            column(Pay_to_Name; "Pay-to Name")
            {
            }
            column(Vendor_Shipment_No_; "Vendor Shipment No.")
            {
            }
            column(Vendor_DO_Date; Format("Vendor DO Date"))
            {
            }
            dataitem("Purchase Header"; "Purchase Header")
            {
                DataItemLink = "No." = field("Order No.");
                DataItemLinkReference = "Purchase Receipt Header";
                column(Currency_Code; "Currency Code")
                {
                }
                column(Amount_Including_VAT; "Amount Including VAT")
                {
                }
                column(Amount; Amount)
                {
                }
                column(BaseValueBase; BaseValueBase)
                {

                }
                column(TotalValueBase; TotalValueBase)
                {

                }
                trigger OnAfterGetRecord()
                begin
                    if "Currency Factor" <> 0 then begin
                        BaseValueBase := Amount / "Currency Factor";
                        TotalValueBase := "Amount Including VAT" / "Currency Factor";
                    end
                    else begin
                        BaseValueBase := Amount;
                        TotalValueBase := "Amount Including VAT";
                    end;
                end;
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
        BaseValueBase: Decimal;
        TotalValueBase: Decimal;
}