pageextension 50087 "Whse. WMS Role Center Ext" extends "Whse. WMS Role Center"
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
        addlast(rolecenter)
        {
            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }
}
