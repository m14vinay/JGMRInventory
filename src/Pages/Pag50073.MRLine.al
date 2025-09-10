page 50073 "MR Line"
{
    ApplicationArea = All;
    Caption = 'MR Line';
    PageType = ListPart;
    SourceTable = "MR Line";
    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ToolTip = 'Specifies the value of the Item Description field.', Comment = '%';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.', Comment = '%';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field.', Comment = '%';
                }
                field("Need Date"; Rec."Need Date")
                {
                    ToolTip = 'Specifies the value of the Need Date field.', Comment = '%';
                }
                field("Issuing Location"; Rec."Issuing Location")
                {
                    ToolTip = 'Specifies the value of the Issuing Location field.', Comment = '%';
                }
            }
        }
    }
}
