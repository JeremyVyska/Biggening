table 88019 "BCS Market Trades"
{
    Caption = 'BCS Market Trades';
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
        field(2; Company; Text[30])
        {
            Caption = 'Company';
            DataClassification = SystemMetadata;
            TableRelation = Company;
        }
        field(3; Date; Date)
        {
            Caption = 'Date';
            DataClassification = SystemMetadata;
        }
        field(10; "Total Trades"; Decimal)
        {
            Caption = 'Total Trades';
            DataClassification = SystemMetadata;
            BlankZero = true;
        }
        field(20; Price; Decimal)
        {
            Caption = 'Price';
            DataClassification = SystemMetadata;
            BlankZero = true;
        }
    }
    keys
    {
        key(PK; "Item No.", Company, Date)
        {
            Clustered = true;
        }
    }

}
