tableextension 50078 "Warehouse WMS Cue Ext" extends "Warehouse WMS Cue"
{
    fields
    {
        field(50070; "Sales Return Orders - Released"; Integer)
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            CalcFormula = count("Sales Header" where("Document Type" = const("Return Order"),
                                                      Status = const(Released)));
            Caption = 'Sales Return Orders - Released';
            Editable = false;
            FieldClass = FlowField;
            ToolTip = 'Specifies the number of sales return orders documents that are displayed in the Sales Cue on the Role Center.';
        }

    }
}
