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

            trigger OnValidate()
            begin
                SafetyCheckTypeTier();
            end;
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

        field(90; "Maximum Doc. Lines Per Op"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Maximum Doc. Lines Per Op';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }

        field(100; "Marketing Bot Item Tier"; Code[20])
        {
            Caption = 'Marketing Bot Item Tier';
            TableRelation = "Gen. Product Posting Group";
        }

        field(500; "Start With"; Integer)
        {
            Caption = 'Start With';
            BlankZero = true;
        }
        field(1000; "Materials"; Integer)
        {
            Caption = 'Materials';
            FieldClass = FlowField;
            CalcFormula = count ("BCS Bot Template Req." where("Bot Template Code" = field(Code)));
            Editable = false;
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

    procedure SafetyCheckTypeTier()
    var
        Template2: Record "BCS Bot Template";
        DuplicateBotTierMsg: Label 'For each Type and Tier, there should only be one template.';
    begin
        if (Rec."Bot Tier" = 0) then
            exit;

        Template2.SetRange("Bot Type", Rec."Bot Type");
        Template2.SetRange("Bot Tier", rec."Bot Tier");
        if not Template2.IsEmpty then
            Error(DuplicateBotTierMsg);
    end;
}