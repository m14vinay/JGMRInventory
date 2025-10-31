pageextension 50079 "Account Receivables Ext " extends "Account Receivables"
{
    layout
    {
        addafter("Acc. Receivable Activities")
        {
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
             part(PRMRActivities;"PR MR Activities")
            {
                ApplicationArea = Suite;
            }
        }
    }
}
