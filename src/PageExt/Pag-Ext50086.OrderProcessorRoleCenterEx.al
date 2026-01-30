pageextension 50086 "Order Processor Role Center Ex" extends "Order Processor Role Center"
{
    layout
    {
        addbefore("Intercompany Activities")
        {
            part(PRMRActivities; "PR MR Activities")
            {
                ApplicationArea = Suite;
            }
        }
        addbefore(Control1901851508)
        {
            part(Control16; "O365 for Sales")
            {
                AccessByPermission = TableData "Activities Cue" = I;
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
