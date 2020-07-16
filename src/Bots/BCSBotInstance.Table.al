table 88001 "BCS Bot Instance"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Instance ID"; Integer)
        {
            Caption = 'MyField';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }


        field(2; "Bot Type"; Enum "BCS Bot Type")
        {
            Caption = 'Bot Type';
            DataClassification = SystemMetadata;
        }

        field(3; "Designation"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Designation';
        }

        field(4; "Bot Name"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Bot Name';
        }

        field(50; "Price"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Price';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }
        field(60; "Power Per Day"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Power Per Day';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }
        field(70; "Operations Per Day"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Ops. Per Day';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }

        field(100; "Power Upgrade Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Power Upgrade Code';
        }
        field(110; "Operations Update Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Operations Upgrade Code';
        }

        field(200; "Assignment Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            TableRelation = if ("Bot Type" = const("Sales")) Customer
            else
            if ("Bot Type" = const(Purchasing)) Vendor
            else
            if ("Bot Type" = const("Inventory-Basic")) Location
            else
            if ("Bot Type" = const("Inventory-Advanced")) Location
            else
            if ("Bot Type" = const(Manufacturing)) "Work Center";
            ValidateTableRelation = true;
        }
    }

    keys
    {
        key(PK; "Instance ID")
        {
            Clustered = true;
        }
    }

}