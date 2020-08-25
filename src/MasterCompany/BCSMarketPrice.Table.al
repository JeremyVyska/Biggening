table 88021 "BCS Market Price"
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
        key(PK; "Item No.")
        {
            Clustered = true;
        }
    }

}
