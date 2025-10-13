tableextension 50073 "Transfer Ship Hdr Ext" extends "Transfer Shipment Header"
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
        modify("Partner VAT ID")
        {
            Caption = 'Partner SST ID';
        }
    }
}
