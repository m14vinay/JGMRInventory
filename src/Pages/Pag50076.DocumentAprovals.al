page 50076 "Document Aprovals"
{
    PageType = CardPart;
    SourceTable = "PR MR Cue";
    RefreshOnActivate = true;
    Caption = 'Document Approvals';
    layout
    {
        area(Content)
        {
             cuegroup(DocumentApprovals)
            {
                Caption = 'Document Approvals';

                field("POs Pending Approval"; Rec."POs Pending Approval")
                {
                    DrillDownPageId = "Purchase Order List";
                    ApplicationArea = All;
                }
                field("Approved Purchase Orders"; Rec."Approved Purchase Orders")
                {
                    DrillDownPageId = "Purchase Order List";
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
        Rec.SetRange("User ID Filter", UserId);
    end;
}
