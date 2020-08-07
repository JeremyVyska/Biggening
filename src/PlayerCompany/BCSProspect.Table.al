table 88012 "BCS Prospect"
{
    Caption = 'BCS Prospect';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; Type; Option)
        {
            OptionMembers = "Customer","Vendor";
            OptionCaption = 'Customer,Vendor';
            Caption = 'Type';
            DataClassification = SystemMetadata;
        }
        field(10; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
        field(50; "Maximum Orders Per Day"; Decimal)
        {
            Caption = 'Maximum Orders Per Day';
            DataClassification = SystemMetadata;
        }
        field(60; "Maximum Quantity Per Order"; Decimal)
        {
            Caption = 'Maximum Quantity Per Order';
            DataClassification = SystemMetadata;
        }
        field(80; "Random Entry Source No."; Integer)
        {
            Caption = 'Random Entry Source No.';
            DataClassification = SystemMetadata;
            TableRelation = "BCS Random Entity Name Pool";
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

}
