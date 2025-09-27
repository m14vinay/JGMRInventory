pageextension 50075 ReleasedProductionOrder extends "Released Production Order"
{
    actions
    {
        addafter("&Print")
        {
            action(RecordingSlipReport)
            {
                ApplicationArea = All;
                Caption = 'Print Recording Slip';
                Image = Report; // Optional icon
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                trigger OnAction()
                var
                    MyReportID: Integer;
                    DocumentNo: Record "Production Order";
                begin
                    MyReportID := Report::RecordingSlipReport;
                    // Run with request page
                    CurrPage.SetSelectionFilter(DocumentNo);
                    Report.RunModal(MyReportID, true, false, DocumentNo);
                end;
            }
        }
    }
}