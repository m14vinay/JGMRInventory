tableextension 50076 "Transfer Shipment Line Ext" extends "Transfer Shipment Line"
{
    fields
    {
          field(50202; "Quantity Pieces"; Decimal)
        {
            Caption = 'Quantity Pieces';
            DataClassification = CustomerContent;
            Editable = false;
            BlankZero = true;
        }
        field(50200; Returnable; Boolean)
        {
            Caption = 'Returnable';
            DataClassification = ToBeClassified;
        }
    }
}
