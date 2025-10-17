tableextension 50077 "Transfer Receipt Line Ext" extends "Transfer Receipt Line"
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
    }
}
