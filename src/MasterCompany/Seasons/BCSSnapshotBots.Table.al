table 88018 "BCS Snapshot Bots"
{
    Caption = 'BCS Snapshot Bots';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "Season No."; Integer)
        {
            Caption = 'Season No.';
            DataClassification = SystemMetadata;
        }
        field(2; "Player No."; Integer)
        {
            Caption = 'Player No.';
            DataClassification = SystemMetadata;
        }
        field(3; "Game Date"; Date)
        {
            Caption = 'Game Date';
            DataClassification = SystemMetadata;
        }
        field(4; "Bot Type"; Enum "BCS Bot Type")
        {
            Caption = 'Bot Type';
            DataClassification = SystemMetadata;
        }
        field(10; "Bot Count"; Integer)
        {
            Caption = 'Bot Count';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Season No.", "Player No.", "Game Date", "Bot Type")
        {
            Clustered = true;
        }
    }

}
