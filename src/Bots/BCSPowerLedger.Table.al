table 88005 "BCS Power Ledger"
{
    Caption = 'BCS Power Ledger';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = false;
        }
        field(10; "Bot Instance"; Integer)
        {
            Caption = 'Bot Instance';
            DataClassification = SystemMetadata;
        }
        field(11; "Bot Type"; Enum "BCS Bot Type")
        {
            Caption = 'Bot Type';
            DataClassification = SystemMetadata;
        }
        field(20; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = SystemMetadata;
        }
        field(30; "Power Usage"; Decimal)
        {
            Caption = 'Power Usage';
            DataClassification = SystemMetadata;
        }
        field(40; "Posted to G/L"; Boolean)
        {
            Caption = 'Posted to G/L';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}
