table 88026 "BCS Market Price Archive"
{
    Caption = 'BCS Market Price';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = SystemMetadata;
            TableRelation = Item;
        }
        field(2; "Season No."; Integer)
        {
            Caption = 'Season No.';
            DataClassification = SystemMetadata;
            TableRelation = "BCS Season"."No.";
        }
        field(10; "Market Price"; Decimal)
        {
            Caption = 'Market Price';
            DataClassification = SystemMetadata;
            DecimalPlaces = 0 : 0;
        }
        field(20; "Last Calculated"; Date)
        {
            Caption = 'Last Calculated';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Season No.", "Item No.")
        {
            Clustered = true;
        }
    }

}
