pageextension 50090 "WMS ShipReceive Activities Ext" extends "WMS Ship & Receive Activities"
{
    layout{
        addafter("Posted Receipts - Today")
        {
            field("Sales Return Orders - Released"; Rec."Sales Return Orders - Released")
                {
                    ApplicationArea = Warehouse;
                    DrillDownPageID = "Sales Return Order List";
                    ToolTip = 'Specifies the number of released sales return orders that are displayed in the Warehouse WMS Cue on the Role Center.';
                }
        }
    }
}
