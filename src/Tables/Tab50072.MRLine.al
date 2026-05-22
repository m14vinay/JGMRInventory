table 50072 "MR Line"
{
    Caption = 'MR Line';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "MR No."; Code[20])
        {
            Caption = 'MR No.';
            Editable = false;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
        }
        field(3; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item Where (Type = CONST(Inventory));
            trigger OnValidate()
            var
                Item: Record Item;
            begin
                CheckStatusOpen();
                If Item.Get("Item No.") then begin
                    Rec."Item Description" := Item.Description;
                    Rec."Unit of Measure Code" := Item."Base Unit of Measure";
                end;
            end;

        }
        field(4; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            Editable = False;
        }
        field(5; "Quantity"; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 2;
            BlankZero = true;
            trigger OnValidate()
            begin
                CheckStatusOpen();
            end;
        }
        field(6; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code where("Item No." = field("Item No."));
        }
        field(7; "Need Date"; Date)
        {
            Caption = 'Need Date';
            trigger OnValidate()
            begin
                CheckStatusOpen();
            end;
        }
        field(8; "Issuing Location"; Code[10])
        {
            Caption = 'Issuing Location';
            TableRelation = Location.Code;
            trigger OnValidate()
            begin
                CheckStatusOpen();
            end;
        }
         field(9; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
           // TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1), Blocked = const(false));
            FieldClass = FlowField;
            CalcFormula = lookup("MR Header"."Shortcut Dimension 1 Code" where("MR No." =  field("MR No.")));
            Editable = false;
        }
    }
    keys
    {
        key(PK; "MR No.", "Line No.")
        {
            Clustered = true;
        }
    }
    var
    MRHeader : Record "MR Header";
     procedure CheckStatusOpen()
    begin
        If MRHeader.Get("MR No.") then
            MRHeader.TestField(MRHeader.Status, MRHeader.Status::Pending);
    end;
    trigger OnInsert()
    begin
        CheckStatusOpen();
    end;
    trigger OnDelete()
    begin
        CheckStatusOpen();
    end;

}
