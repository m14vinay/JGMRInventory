pageextension 50089 "Purchase Agent Activites Ext" extends "Purchasing Agent Role Center"
{
    layout
    {
        addbefore("User Tasks Activities")
        {
             part(PRMRActivities;"PR MR Activities")
            {
                ApplicationArea = Suite;
            }
              part(PCActivities;"Price Comparison Activities")
            {
                ApplicationArea = Suite;
            }
        }
        
       
    }
}
