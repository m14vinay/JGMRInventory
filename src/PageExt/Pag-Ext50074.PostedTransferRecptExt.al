pageextension 50074 "Posted Transfer Recpt Ext" extends "Posted Transfer Receipt"
{
    layout
    {
        addafter("Posting Date")
        {
            field("Vehicle No"; Rec."Vehicle No")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Driver Name"; Rec."Driver Name")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
