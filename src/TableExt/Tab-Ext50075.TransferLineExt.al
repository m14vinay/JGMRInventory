tableextension 50075 "Transfer Line Ext" extends "Transfer Line"
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
        modify(Quantity)
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                PackSize: Record "Pack Size";
            begin
                If Item.Get("Item No.") then
                    If PackSize.Get(Item."Pack Size") then
                        "Quantity Pieces" := PackSize."Qty Per Pack" * Quantity;
            end;
        }
        modify("Item No.")
        {
            trigger OnAfterValidate()
            var
                Item: Record Item;
                PackSize: Record "Pack Size";
            begin
                If Quantity <> 0 then
                If Item.Get("Item No.") then
                    If PackSize.Get(Item."Pack Size") then
                        "Quantity Pieces" := PackSize."Qty Per Pack" * Quantity;
            end;
        }
    }
}
