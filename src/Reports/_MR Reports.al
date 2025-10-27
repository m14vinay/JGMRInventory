report 50071 "Material Requisition Report"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Material Requisition Report';
    DefaultLayout = RDLC;
    RDLCLayout = 'src/Reports/Layouts/MaterialRequisitionReport.rdl'; // update path if needed
    dataset
    {
        dataitem(MRHeader; "MR Header")
        {
            RequestFilterFields = "MR No.", "MR Date", Status, "Requested By", "Shortcut Dimension 1 Code";
            // Company Information
            column(CompanyName; CompanyInfo.Name) { }
            column(CompanyAddress1; CompanyInfo.Address) { }
            column(CompanyAddress2; CompanyInfo."Address 2") { }
            column(CompanyCity; CompanyInfo.City) { }
            column(CompanyPostCode; CompanyInfo."Post Code") { }
            column(CompanyState; GetCountyName()) { }
            column(CompanyCountry; CompanyCountry) { }
            column(CompanyLogo; CompanyInfo.Picture) { }
            column(CompanyRegNo; CompanyInfo."Registration No.") { }
            // MR Header
            column(MRNo; MRHeader."MR No.") { }
            column(MRDate; MRHeader."MR Date") { }
            column(RequestedBy; MRHeader."Requested By") { }
            column(RequestedByFullName; RequestedByFullName) { }
            column(Department; MRHeader."Shortcut Dimension 1 Code") { }
            column(Status; Format(MRHeader.Status)) { }
            column(Remarks; MRHeader.Remarks) { }
            dataitem(MRLine; "MR Line")
            {
                DataItemLink = "MR No." = field("MR No.");
                DataItemTableView = sorting("MR No.", "Line No.");
                column(LineNo; LineNo) { }
                column(ItemNo; MRLine."Item No.") { }
                column(ItemDescription; MRLine."Item Description") { }
                column(Quantity; MRLine.Quantity) { }
                column(UnitOfMeasure; MRLine."Unit of Measure Code") { }
                column(NeedDate; MRLine."Need Date") { }
                column(IssuingLocation; MRLine."Issuing Location") { }
                trigger OnAfterGetRecord()
                begin
                    LineNo += 1;
                end;

                trigger OnPreDataItem()
                begin
                    LineNo := 0;
                end;
            }
            trigger OnAfterGetRecord()
            begin
                GetCompanyInfo();
                GetRequestedByFullName();
            end;
        }
    }
    // requestpage
    // {
    //     SaveValues = true;
    //     layout
    //     {
    //         area(Content)
    //         {
    //             // Future options go here
    //         }
    //     }
    // }
    trigger OnInitReport()
    begin
        GetCompanyInfo();
        CompanyInfo.SetAutoCalcFields(Picture);
    end;

    var
        CompanyInfo: Record "Company Information";
        CountryRegion: Record "Country/Region";
        UserRec: Record User;
        CompanyCountry: Text;
        RequestedByFullName: Text;
        LineNo: Integer;

    local procedure GetCompanyInfo()
    begin
        if not CompanyInfo.Get() then
            CompanyInfo.Init();
        if CompanyInfo."Country/Region Code" <> '' then begin
            if CountryRegion.Get(CompanyInfo."Country/Region Code") then
                CompanyCountry := CountryRegion.Name;
        end;
    end;

    local procedure GetRequestedByFullName()
    begin
        RequestedByFullName := MRHeader."Requested By"; // Default to username

        UserRec.Reset();
        UserRec.SetRange("User Name", MRHeader."Requested By");
        if UserRec.FindFirst() then
            RequestedByFullName := UserRec."Full Name";
    end;

    local procedure GetCountyName(): Text
    var
        CountyRec: Record County;
    begin
        if (CompanyInfo.County <> '') then
            if CountyRec.Get(CompanyInfo.County) then
                exit(CountyRec.Description);

        exit(CompanyInfo.County);
    end;
}