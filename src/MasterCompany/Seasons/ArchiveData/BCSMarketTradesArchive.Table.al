table 88028 "BCS Market Trades Archive"
{
    Caption = 'BCS Market Trades Archive';
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
        field(4; "Season No."; Integer)
        {
            Caption = 'Season No.';
            DataClassification = SystemMetadata;
            TableRelation = "BCS Season"."No.";
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
        key(PK; "Season No.", "Item No.", Company, Date)
        {
            Clustered = true;
        }
    }

}
