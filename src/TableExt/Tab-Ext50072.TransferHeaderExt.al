tableextension 50072 "Transfer Header Ext" extends "Transfer Header"
{
    fields
    {
        field(50071; "Vehicle No"; Code[20])
        {
            Caption = 'Vehicle No';
        }
        field(50072; "Driver Name"; Text[100])
        {
            Caption = 'Driver Name';
        }
         field(50073; "Supplier"; Text[50])
        {
            Caption = 'Supplier';
            DataClassification = CustomerContent;
        }
        modify("Partner VAT ID")
        {
            Caption = 'Partner SST ID';
        }
    }
}
