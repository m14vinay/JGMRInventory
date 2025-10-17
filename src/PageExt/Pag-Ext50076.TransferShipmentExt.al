pageextension 50076 "Transfer Shipment Ext" extends "Posted Transfer Shipment Lines"
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
