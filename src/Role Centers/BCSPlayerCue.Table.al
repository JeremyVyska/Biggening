table 88002 "BCS Player Cue"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = SystemMetadata;
        }

        field(100; "Total Bot Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("BCS Bot Instance");
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}