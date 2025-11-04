pageextension 50078 "Acntng Mnger RoleCenter Ext" extends "Accounting Manager Role Center"
{
    layout
    {
        addafter(Control1902304208)
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
    actions
    {

        addlast(sections)
        //addbefore(Action41)
        {
            group("ADY D365 e-Invoice")
            {
                Caption = 'e-Invoice';

                group("ADY e-Inv Transaction")
                {
                    Caption = 'Transaction';

                    action("ADY e-Inv Sales Documents")
                    {
                        Caption = 'e-Invoice Sales Documents';

                        RunObject = page "ADY e-Inv Sales Documents";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Purch Documents")
                    {
                        Caption = 'e-Invoice Self-Billed Documents';

                        RunObject = page "ADY e-Inv Purch Documents";
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Conso Sales Invoice")
                    {
                        Caption = 'e-Invoice Conso Sales Invoice';

                        RunObject = page "ADY e-Inv Conso Sales Inv";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Conso Sales Credit Note")
                    {
                        Caption = 'e-Invoice Conso Sales Credit Note';

                        RunObject = page "ADY e-Inv Conso Sales CN";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Purchase As Sales Documents")
                    {
                        Caption = 'e-Invoice Purchase As Sales Documents';

                        RunObject = page "ADY e-Inv Purch Doc As Sales";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVPAS;
                    }

                    action("ADY e-Inv Customers")
                    {
                        Caption = 'Request Customers e-Invoice Info';

                        RunObject = page "ADY e-Inv Customer";
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Vendors")
                    {
                        Caption = 'Request Vendors e-Invoice Info';

                        RunObject = page "ADY e-Inv Vendor";
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Pending Documents")
                    {
                        Caption = 'e-Invoice Pending Documents';
                        RunObject = page "ADY e-Inv Pending Documents";
                        ApplicationArea = ADYEINVOICE;
                        Visible = false;
                    }

                }

                group("ADY e-Inv Inquiry")
                {
                    Caption = 'Inquiry';

                    action("ADY e-Inv Sales Documents Inquiry")
                    {
                        Caption = 'e-Invoice Sales Documents (Submitted)';

                        RunObject = page "ADY e-Inv Sales Doc Inquiry";
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Purch Documents Inquiry")
                    {
                        Caption = 'e-Invoice Self-Billed Documents (Submitted)';

                        RunObject = page "ADY e-Inv Purch Doc Inquiry";
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv P-Doc As Sales Inquiry")
                    {
                        Caption = 'e-Invoice Purchase As Sales Documents (Submitted)';

                        RunObject = page "ADY e-Inv P-Doc As Sales Inq";
                        ApplicationArea = ADYEINVPAS;
                    }

                    action("ADY e-Inv Sales Documents Excluded")
                    {
                        Caption = 'e-Invoice Sales Documents (Removed)';

                        RunObject = page "ADY e-Inv Sales Doc Excluded";
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Purch Documents Excluded")
                    {
                        Caption = 'e-Invoice Self-Billed Documents (Removed)';

                        RunObject = page "ADY e-Inv Purch Doc Excluded";
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Submitted Documents")
                    {
                        Caption = 'e-Invoice Submitted Documents (LHDN)';

                        RunObject = page "ADY e-Inv Submitted Documents";
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Received Documents")
                    {
                        Caption = 'e-Invoice Received Documents (LHDN)';

                        RunObject = page "ADY e-Inv Received Documents";
                        ApplicationArea = ADYEINVOICE;
                    }

                }



                group("ADY e-Inv Setup")
                {
                    Caption = 'Setting';

                    action("ADY e-Inv Company Information")
                    {
                        Caption = 'e-Invoice Information';

                        RunObject = page "ADY e-Inv Comp Info Add Info";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv API Master Setup")
                    {
                        Caption = 'API Master Setup';

                        RunObject = page "ADY e-Inv API Master Setup";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Document Type Setup")
                    {
                        Caption = 'Document Type Setup';
                        RunObject = page "ADY e-Inv Document Type Setup";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv UOM Setup")
                    {
                        Caption = 'UOM Setup';
                        RunObject = page "ADY e-Inv UOM Setup";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv MSIC Setup")
                    {
                        Caption = 'MSIC Setup';
                        RunObject = page "ADY e-Inv MSIC Setup";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv State Setup")
                    {
                        Caption = 'State Setup';
                        RunObject = page "ADY e-Inv State Setup";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Tax Type Setup")
                    {
                        Caption = 'Tax Type Setup';
                        RunObject = page "ADY e-Inv Tax Type Setup";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Payment Mode Setup")
                    {
                        Caption = 'Payment Mode Setup';
                        RunObject = page "ADY e-Inv Payment Mode Setup";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Classification Setup")
                    {
                        Caption = 'Classification Setup';
                        RunObject = page "ADY e-Inv Classification Setup";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv General TIN Setup")
                    {
                        Caption = 'General TIN Setup';
                        RunObject = page "ADY e-Inv General TIN Setup";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Incoterms Setup")
                    {
                        Caption = 'Incoterms Setup';
                        RunObject = page "ADY e-Inv Incoterms Setup";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Certificate Setup")
                    {
                        Caption = 'Certificate Setup';
                        RunObject = page "ADY e-Inv Certificate Setup";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Character Setup")
                    {
                        Caption = 'Character List';
                        RunObject = page "ADY e-Inv Character To Replace";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Cust/Vend Form Setup")
                    {
                        Caption = 'Customer/Vendor Form Setup';
                        RunObject = page "ADY e-Inv Cust/Vend Form Setup";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                    action("ADY e-Inv Email Template")
                    {
                        Caption = 'Email Template Setup';
                        RunObject = page "ADY e-Inv Email Templates";
                        RunPageMode = Edit;
                        ApplicationArea = ADYEINVOICE;
                    }

                }
            }
        }

    }
}
