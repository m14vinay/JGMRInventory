page 50072 "MR Header List"
{
    ApplicationArea = All;
    Caption = 'Material Requisition List';
    PageType = List;
    SourceTable = "MR Header";
    UsageCategory = Lists;
    CardPageId = "MR Header";
    Editable = false;
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
                field("MR Date"; Rec."MR Date")
                {
                    ToolTip = 'Specifies the value of the MR Date field.', Comment = '%';
                }
                field("Requested By"; Rec."Requested By")
                {
                    ToolTip = 'Specifies the value of the Requested By field.', Comment = '%';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
            }
        }
    }
}
