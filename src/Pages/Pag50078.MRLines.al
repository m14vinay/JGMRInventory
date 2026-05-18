page 50078 "MR Lines"
{
    ApplicationArea = All;
    Caption = 'MR Lines';
    PageType = List;
    SourceTable = "MR Line";
    UsageCategory = Lists;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("MR No."; Rec."MR No.")
                {
                    ToolTip = 'Specifies the value of the MR No. field.', Comment = '%';
                }
                field("Line No."; Rec."Line No.")
                {
                    ToolTip = 'Specifies the value of the Line No. field.', Comment = '%';
                }
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
