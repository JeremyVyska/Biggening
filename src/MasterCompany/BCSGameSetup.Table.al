table 88004 "BCS Game Setup"
{
    DataPerCompany = false;
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }

        field(10; "Game Date"; Date)
        {
            Caption = 'Game Date';
            DataClassification = SystemMetadata;
        }

        field(20; "Purchase Prospect Effort"; Integer)
        {
            Caption = 'Purchase Prospect Effort';
            DataClassification = SystemMetadata;
        }
        field(21; "Purch. Pros. Tier Multiplier"; Decimal)
        {
            Caption = 'Purch. Pros. Tier Multiplier';
            DataClassification = SystemMetadata;
            InitValue = 1;
        }
        field(22; "Purch. Pros. Base Max Orders"; Integer)
        {
            Caption = 'Purch. Pros. Base Max Orders';
            DataClassification = SystemMetadata;
            InitValue = 10;
        }
        field(23; "Purch. Pros. Base Max Quantity"; Integer)
        {
            Caption = 'Purch. Pros. Base Max Quantity';
            DataClassification = SystemMetadata;
            InitValue = 50;
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