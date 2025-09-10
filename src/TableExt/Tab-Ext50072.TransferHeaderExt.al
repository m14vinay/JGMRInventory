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
    }
}
