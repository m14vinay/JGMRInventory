pageextension 50091 "Team Member Role Center Ext" extends "Team Member Role Center"
{
    layout
    {
        addlast(rolecenter)
        {
            part(PowerBIEmbeddedReportPart; "Power BI Embedded Report Part")
            {
                ApplicationArea = Basic, Suite;
            }
        }
         addbefore(ApprovalsActivities)
        {
            part(PRMRActivities; "PR MR Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }
}
