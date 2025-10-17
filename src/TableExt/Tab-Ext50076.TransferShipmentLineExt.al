tableextension 50076 "Transfer Shipment Line Ext" extends "Transfer Shipment Line"
{
    fields
    {
        field(50071; "Returnable"; Boolean)
        {
            Caption = 'Returnable';
            DataClassification = CustomerContent;
        }
    }
}
