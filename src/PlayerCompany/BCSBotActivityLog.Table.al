table 88006 "BCS Bot Activity Log"
{
    Caption = 'BCS Bot Activity Log';
    DataClassification = ToBeClassified;

    //TODO: Clean up table

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
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
        field(50; Description; Text[200])
        {
            Caption = 'Description';
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
