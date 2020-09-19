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
        field(6; "Bot Template Code"; Code[20])
        {
            Caption = 'Bot Template';
            DataClassification = SystemMetadata;
            TableRelation = "BCS Bot Template";
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

            trigger OnValidate()
            var
                BCSCheckAssignment: Codeunit "BCS Bot Check Assignment";
            begin
                BCSCheckAssignment.CheckAssignment(Rec);
            end;
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
    var
        CalculatedPowerPerDay: Decimal;
    begin
        CalculatedPowerPerDay := Rec."Power Per Day";
        OnBeforeGetPowerPerDay(Rec, CalculatedPowerPerDay);
        exit(CalculatedPowerPerDay);
    end;

    procedure GetOpsPerDay(): Decimal
    var
        CalculatedOpsPerDay: Decimal;
    begin
        CalculatedOpsPerDay := Rec."Operations Per Day";
        OnBeforeGetOpsPerDay(Rec, CalculatedOpsPerDay);
        exit(CalculatedOpsPerDay);
    end;

    procedure GetResearchPerOp(): Decimal
    begin
        exit(Rec."Research Points Per Op");
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetPowerPerDay(Rec: Record "BCS Bot Instance"; var CalculatedPowerPerDay: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetOpsPerDay(Rec: Record "BCS Bot Instance"; var CalculatedOpsPerDay: Decimal)
    begin
    end;
}