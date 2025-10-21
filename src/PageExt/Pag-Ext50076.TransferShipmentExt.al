pageextension 50076 "Transfer Shipment Ext" extends "Posted Transfer Shpt. Subform"
{
    layout{
        addafter(Quantity)
        {
            field("Quantity Pieces"; Rec."Quantity Pieces")
            {
                ToolTip = 'Specifies the Quantity Pieces';
                ApplicationArea = All;
                Editable = false;
            }
            field(Returnable; Rec.Returnable)
            {
                ToolTip = 'Specifies Returnable';
                ApplicationArea = All;
                Editable = false;
            }
        }
    }
}
