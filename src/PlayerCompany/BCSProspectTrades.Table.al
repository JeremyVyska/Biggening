table 88013 "BCS Prospect Trades"
{
    Caption = 'BCS Propect Trades';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Prospect No."; Integer)
        {
            Caption = 'Prospect No.';
            DataClassification = SystemMetadata;
            TableRelation = "BCS Prospect";
        }
        field(2; "Prospect Type"; Option)
        {
            Caption = 'Prospect Type';
            FieldClass = FlowField;
            OptionMembers = "Customer","Vendor";
            OptionCaption = 'Customer,Vendor';
            CalcFormula = lookup ("BCS Prospect".Type where("No." = field("Prospect No.")));
        }
        field(10; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(20; "Trade Type"; Option)
        {
            Caption = 'Trade Type';
            DataClassification = SystemMetadata;
            OptionMembers = "Item","Item Category";
            OptionCaption = 'Item,Item Category';
        }
        field(30; "Trade Code"; Code[20])
        {
            Caption = 'Trade Code';
            DataClassification = SystemMetadata;
            TableRelation = if ("Trade Type" = const(Item)) Item else
            if ("Trade Type" = const("Item Category")) "Item Category";
        }
    }
    keys
    {
        key(PK; "Prospect No.", "Line No.")
        {
            Clustered = true;
        }
    }

}
