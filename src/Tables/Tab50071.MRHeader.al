table 50071 "MR Header"
{
    Caption = 'MR Header';
    DataClassification = ToBeClassified;
    LookupPageId = "MR Header List";
    fields
    {
        field(1; "MR No."; Code[20])
        {
            Caption = 'MR No.';
            Editable = false;
        }
        field(2; "MR Date"; Date)
        {
            Caption = 'MR Date';
            Editable = false;
        }
        field(3; "Requested By"; Text[50])
        {
            Caption = 'Requested By';
            Editable = false;
        }
        field(4; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
            Editable = false;
        }
        field(5; Status; enum "MR Status")
        {
            Caption = 'Status';
            Editable = false;
        }
        field(6; "Item Journal Created"; Boolean)
        {
            Caption = 'Item Journal Created';
            Editable = false;
        }
        field(7; "Remarks"; Text[100])
        {
            Caption = 'Remarks';
            trigger OnValidate()
            begin
                TestField(Status,Status::Pending);
            end;
        }
         field(8; "Assigned To"; Code[50])
        {
            Caption = 'Employee Assigned';
            TableRelation = Employee."First Name";
            ValidateTableRelation = false;
        }
    }
    keys
    {
        key(PK; "MR No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        InventorySetup: Record "Inventory Setup";
        NoSeries: Codeunit "No. Series";
    begin
        InventorySetup.Get();
        Rec."MR No." := NoSeries.GetNextNo(InventorySetup."MR No.", Today(), true);
    end;

    trigger OnDelete()
    var
        MRLine: Record "MR Line";
    begin
        TestField(Status, Status::Pending);
        MRLine.Reset();
        MRLine.SetRange("MR No.", Rec."MR No.");
        If MRLine.FindFirst() then
            MRLine.DeleteAll();
    end;
}
