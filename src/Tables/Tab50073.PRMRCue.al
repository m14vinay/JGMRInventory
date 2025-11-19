table 50073 "PR MR Cue"
{
    Caption = 'PR MR Cue';
    DataClassification = CustomerContent;
    
    fields
    {
         field(1; "Primary Key"; Code[10])
        {
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
        }
        field(2; "Price Comparison Open"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Price Comparison Open';
            Editable = false;
            CalcFormula = count("Price Comparison Header" where("Status" = filter(Open)));
        }
        field(3; "Price Comparison Approved"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Price Comparison Approved';
            Editable = false;
            CalcFormula = count("Price Comparison Header" where("Status" = filter(Released),"PO Created" = const(false)));
        }
        field(4; "PC Pending Approval"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Price Comparison Pending Approval';
            Editable = false;
            CalcFormula = count("Price Comparison Header" where("Status" = filter("Pending Approval")));
        }
         field(24; "Price Comparison Processed"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Price Comparison Processed';
            Editable = false;
            CalcFormula = count("Price Comparison Header" where("Status" = filter(Released),"PO Created" = const(True)));
        }
        field(5; "Purchase Request Open"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Purchase Request Open';
            Editable = false;
            CalcFormula = count("Purchase Request Header" where("Status" = filter(Open)));
        }
        field(6; "Purchase Request Approved"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Purchase Request Approved';
            Editable = false;
            CalcFormula = count("Purchase Request Header" where("Status" = filter(Released),"PO Created" = const(false)));
        }
        field(7; "PR Pending Approval"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Purchase Request Pending Approval';
            Editable = false;
            CalcFormula = count("Purchase Request Header" where("Status" = filter("Pending Approval")));
        }
         field(8; "MR Pending"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Material Requisition Pending';
            Editable = false;
            CalcFormula = count("MR Header" where("Status" = filter("Pending")));
        }
         field(9; "MR Submitted"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Material Requisition Submitted';
            Editable = false;
            CalcFormula = count("MR Header" where("Status" = filter(Submitted)));
        }
         field(10; "MR Issued"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Material Requisition Issued';
            Editable = false;
            CalcFormula = count("MR Header" where("Status" = filter("Issued")));
        }
        field(20; "Date Filter"; Date)
        {
            Caption = 'Date Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(21; "Responsibility Center Filter"; Code[10])
        {
            Caption = 'Responsibility Center Filter';
            Editable = false;
            FieldClass = FlowFilter;
        }
        field(22; "User ID Filter"; Code[50])
        {
            Caption = 'User ID Filter';
            FieldClass = FlowFilter;
        }
           field(23; "Purchase Request Processed"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Purchase Request Processed';
            Editable = false;
            CalcFormula = count("Purchase Request Header" where("Status" = filter(Released),"PO Created" = const(True)));
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}
