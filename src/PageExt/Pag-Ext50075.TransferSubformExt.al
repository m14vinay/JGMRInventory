pageextension 50075 "Transfer Subform Ext" extends "Transfer Order Subform"
{
    layout{
        addafter(Quantity)
        {
            field(Returnable; Rec.Returnable)
            {
                ToolTip = 'Specifies Returnable';
                ApplicationArea = All;
                Editable = true;
            }
        }
    }
}
