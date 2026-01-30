page 50075 "Price Comparison Activities"
{
    Caption = 'Price Comparison Activities';
    PageType = CardPart;
    SourceTable = "PR MR Cue";
    RefreshOnActivate = true;
    
    layout
    {
        area(Content)
        { 
            cuegroup("Price Comparison")
            {
                Caption = 'Price Comparison';
                field("Price Comparison Open"; Rec."Price Comparison Open")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Price Comparison List";
                    Caption = 'Open PC';
                    ToolTip = 'Specifies the number of Price Comparison records that are Open on the Role Center.';
                }
                field("PC Pending Approval"; Rec."PC Pending Approval")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Price Comparison List";
                    Caption = 'Pending Approval PC';
                    ToolTip = 'Specifies the number of Price Comparison records that are Pending Approval on the Role Center.';
                }
                field("Price Comparison Approved"; Rec."Price Comparison Approved")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Price Comparison List";
                    Caption = 'Approved PC';
                    ToolTip = 'Specifies the number of Price Comaprison records that are Approved on the Role Center.';
                }
                 field("Price Comparison Processed"; Rec."Price Comparison Processed")
                {
                    ApplicationArea = All;
                    DrillDownPageID = "Price Comparison List";
                    Caption = 'Processed PC';
                    ToolTip = 'Specifies the number of Price Comaprison records that are Processed on the Role Center.';
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
