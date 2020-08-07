table 88000 "BCS Bot Template"
{
    DataClassification = SystemMetadata; //GDPR
    Caption = 'BCS Bot Template';
    DataPerCompany = false;

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = SystemMetadata;
        }
        field(2; "Bot Type"; Enum "BCS Bot Type")
        {
            Caption = 'Bot Type';
            DataClassification = SystemMetadata;
        }
        field(5; "Bot Tier"; Integer)
        {
            Caption = 'Bot Tier';
            DataClassification = SystemMetadata;
        }
        field(10; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }

        field(50; "Base Price"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Base Price';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }
        field(60; "Base Power Per Day"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Base Power Per Day';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }
        field(70; "Base Operations Per Day"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Base Ops. Per Day';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }

        field(80; "Research Points Per Op"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Research Points Per Op.';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; Code, "Bot Type", Description)
        {

        }
    }

}