table 88001 "BCS Bot Instance"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Instance ID"; Integer)
        {
            Caption = 'Instance ID';
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

            trigger OnValidate()
            begin
                if "Bot Name" = '' then
                    "Bot Name" := Designation;
            end;
        }

        field(4; "Bot Name"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Bot Name';
        }

        field(5; "Bot Tier"; Integer)
        {
            Caption = 'Bot Tier';
            DataClassification = SystemMetadata;
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

        field(80; "Research Points Per Op"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Research Points Per Op.';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
            //TODO: Editable = false;
        }

        field(90; "Maximum Doc. Lines Per Op"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Maximum Doc. Lines Per Op';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
            //TODO: Editable = false;
        }

        field(100; "Power Upgrade Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Power Upgrade Code';
        }
        field(110; "Operations Upgrade Code"; Code[20])
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
        key(Tier; "Bot Type", "Bot Tier")
        {

        }
    }

    procedure GetPowerPerDay(): Decimal
    begin
        exit(Rec."Power Per Day");
    end;

    procedure GetOpsPerDay(): Decimal
    begin
        exit(Rec."Operations Per Day");
    end;

    procedure GetResearchPerOp(): Decimal
    begin
        exit(Rec."Research Points Per Op");
    end;
}