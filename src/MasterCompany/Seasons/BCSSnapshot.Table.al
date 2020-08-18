table 88017 "BCS Snapshot"
{
    Caption = 'BCS Snapshot';
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
        field(10; "Wealth Balance"; Decimal)
        {
            Caption = 'Wealth Balance';
            DataClassification = SystemMetadata;
        }
        field(20; "Wealth Net Change"; Decimal)
        {
            Caption = 'Wealth Net Change';
            DataClassification = SystemMetadata;
        }
        field(30; "Location Counts"; Integer)
        {
            Caption = 'Location Counts';
            DataClassification = SystemMetadata;
        }
        field(40; "Customer Counts"; Integer)
        {
            Caption = 'Customer Counts';
            DataClassification = SystemMetadata;
        }
        field(50; "Vendor Counts"; Integer)
        {
            Caption = 'Vendor Counts';
            DataClassification = SystemMetadata;
        }
        field(60; "Power Usage"; Decimal)
        {
            Caption = 'Power Usage';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Season No.", "Player No.", "Game Date")
        {
            Clustered = true;
        }
    }

}
