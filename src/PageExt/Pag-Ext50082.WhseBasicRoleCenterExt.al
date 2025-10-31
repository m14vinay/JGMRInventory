pageextension 50082 "Whse. Basic Role Center Ext" extends "Whse. Basic Role Center"
{
    layout
    {
        addafter(ApprovalsActivities)
        {
             part(PRMRActivities;"PR MR Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }
}
