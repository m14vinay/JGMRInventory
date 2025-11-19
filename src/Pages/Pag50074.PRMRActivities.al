page 50074 "PR MR Activities"
{
    Caption = 'PR MR Activities';
    PageType = CardPart;
    SourceTable = "PR MR Cue";
    RefreshOnActivate = true;
    
    layout
    {
        area(Content)
        {
             
            cuegroup("Purchase Requests")
            {
                Caption = 'Purchase Requests';
                field("Purchase Request Open"; Rec."Purchase Request Open")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Purchase Request List";
                    Caption = 'Open PR';
                    ToolTip = 'Specifies the number of Purchase Request records that are Open on the Role Center.';
                }
                field("PR Pending Approval"; Rec."PR Pending Approval")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Purchase Request List";
                    Caption = 'Pending Approval PR';
                    ToolTip = 'Specifies the number of Purchase Request records that are Pending Approval on the Role Center.';
                }
                field("Purchase Request Approved"; Rec."Purchase Request Approved")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Purchase Request List";
                    Caption = 'Approved PR';
                    ToolTip = 'Specifies the number of Purchase Request records that are Approved on the Role Center.';
                }
                 field("Purchase Request Processed"; Rec."Purchase Request Processed")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Purchase Request List";
                    Caption = 'Processed PR';
                    ToolTip = 'Specifies the number of Purchase Request records that are Processed on the Role Center.';
                }
            }
            cuegroup("Material Requisition")
            {
                Caption = 'Material Requisition';
                field("Material Requisition Pending"; Rec."MR Pending")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "MR Header List";
                    Caption = 'Pending MR';
                    ToolTip = 'Specifies the number of Material Requisition records that are Pending on the Role Center.';
                }
                 field("Material Requisition Submitted"; Rec."MR Submitted")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "MR Header List";
                    Caption = 'Submitted MR';
                    ToolTip = 'Specifies the number of Material Requisition records that are Submitted on the Role Center.';
                }
                field("Material Requisition Issued"; Rec."MR Issued")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "MR Header List";
                    Caption = 'Issued MR';
                    ToolTip = 'Specifies the number of Material Requisition records that are Issued on the Role Center.';
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
