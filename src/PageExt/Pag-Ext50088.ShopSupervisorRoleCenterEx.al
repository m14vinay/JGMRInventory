pageextension 50088 "Shop Supervisor Role Center Ex" extends "Shop Supervisor Role Center"
{
     layout
    {
        addbefore("User Tasks Activities")
        {
             part(PRMRActivities;"PR MR Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }
}
