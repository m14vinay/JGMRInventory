pageextension 50072 TransferOrder extends "Transfer Order"
{
    layout
    {
        addafter(Status)
        {
            field("Vehicle No"; Rec."Vehicle No")
            {
                ApplicationArea = All;
            }
            field("Driver Name"; Rec."Driver Name")
            {
                ApplicationArea = All;
            }
              field(Supplier; Rec.Supplier)
            {
                ToolTip = 'Specifies Supplier';
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        addafter("&Print")
        {
            action(CustomActionForGatePass)
            {
                ApplicationArea = All;
                Caption = 'Print Gate Pass';
                Image = Report; // Optional icon
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Category8;
                trigger OnAction()
                var
                    MyReportID: Integer;
                    DocumentNo: Record "Transfer Header";
                begin
                    MyReportID := Report::GatePassReport; // Replace with your report ID or name
                                                          // Run without request page
                                                          // Report.Run(MyReportID, false, false); 

                    // Run with request page
                    CurrPage.SetSelectionFilter(DocumentNo);

                    Report.RunModal(MyReportID, true, false, DocumentNo);
                end;
            }
        }
    }
}