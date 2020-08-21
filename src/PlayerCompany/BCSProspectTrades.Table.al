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
        field(30; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = SystemMetadata;
            TableRelation = Item;
        }
        field(40; "Prod. Posting Group"; Code[20])
        {
            Caption = 'Prod. Posting Group';
            DataClassification = SystemMetadata;
            TableRelation = "Gen. Product Posting Group";
        }
        field(50; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = SystemMetadata;
            TableRelation = "Item Category";
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
