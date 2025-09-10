pageextension 50071 "Item Journal Batch Ext" extends "Item Journal Batches"
{
    layout{
        addafter("No. Series")
        {
            field("MR Batch"; Rec."MR Batch")
            {
                ApplicationArea = All;
            }
        }
    }
}
