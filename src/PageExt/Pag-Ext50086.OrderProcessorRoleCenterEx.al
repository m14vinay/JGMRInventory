pageextension 50086 "Order Processor Role Center Ex" extends "Order Processor Role Center"
{
     layout
    {
        addbefore("Intercompany Activities")
        {
             part(PRMRActivities;"PR MR Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }
}
