pageextension 50073 "Posted Transfer Shi Ext" extends "Posted Transfer Shipment"
{
    layout{
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
