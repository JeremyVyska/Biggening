table 88014 "BCS Research Progress"
{
    Caption = 'BCS Research';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
            Editable = false;
            TableRelation = "BCS Research";
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            FieldClass = FlowField;
            CalcFormula = lookup ("BCS Research".Description where("No." = field("No.")));
        }
        field(20; Points; Integer)
        {
            Caption = 'Points';
            DataClassification = SystemMetadata;
        }

        field(25; Progress; Integer)
        {
            Caption = 'Progress';
            DataClassification = SystemMetadata;

            trigger OnValidate()
            begin
                if (Progress > Points) then
                    Progress := Points;
                if (Progress = Points) then begin
                    Completed := true;
                    OnAfterResearchProgressComplete(Rec);
                    Selected := false;
                end;
            end;
        }

        field(28; Completed; Boolean)
        {
            Caption = 'Completed';
            DataClassification = SystemMetadata;
        }

        field(40; "Research Type"; Enum "BCS Research Type")
        {
            Caption = 'Research Type';
            DataClassification = SystemMetadata;
        }

        field(50; "Operations Per Day Bonus"; Integer)
        {
            Caption = 'Operations Per Day Bonus';
            DataClassification = SystemMetadata;
            BlankZero = true;
        }

        field(51; "Operation Bonus Type"; Option)
        {
            Caption = 'Operation Bonus Type';
            OptionMembers = " ","Bot Templates","Upgrades";
            OptionCaption = ' ,Bot Template Code,Upgrade Code';
            DataClassification = SystemMetadata;
        }
        field(52; "Operation Bonus Code"; Code[20])
        {
            Caption = 'Operation Bonus Code';
            DataClassification = SystemMetadata;
            TableRelation = if ("Operation Bonus Type" = const("Bot Templates")) "BCS Bot Template";
            //TODO: v0.2 Need to link the TableRelation to Upgrade Kits
        }

        field(60; "Power Per Day Bonus"; Integer)
        {
            Caption = 'Power Per Day Bonus';
            DataClassification = SystemMetadata;
            BlankZero = true;
        }

        field(61; "Power Bonus Type"; Option)
        {
            Caption = 'Power Bonus Type';
            DataClassification = SystemMetadata;
            OptionMembers = " ","Bot Templates","Upgrades";
            OptionCaption = ' ,Bot Template Code,Upgrade Code';
        }
        field(62; "Power Bonus Code"; Code[20])
        {
            Caption = 'Power Bonus Code';
            DataClassification = SystemMetadata;
            TableRelation = if ("Power Bonus Type" = const("Bot Templates")) "BCS Bot Template";
            //TODO: v0.2 Need to link the TableRelation to Upgrade Kits
        }

        field(70; "Prospect Maximum Multiplier"; Integer)
        {
            Caption = 'Prospect Maximum Multiplier';
            DataClassification = SystemMetadata;
            BlankZero = true;
        }

        field(80; "Product Posting Group"; Code[20])
        {
            Caption = 'Product Posting Group';
            DataClassification = SystemMetadata;
            TableRelation = "Gen. Product Posting Group";
        }
        field(90; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = SystemMetadata;
            TableRelation = "Item Category";
        }

        //TODO: v0.2 Adv Location Unlocking?


        field(500; "Selected"; Boolean)
        {
            DataClassification = SystemMetadata;
            Caption = 'Selected';

            trigger OnValidate()
            var
                BCSResearch2: Record "BCS Research Progress";
            begin
                BCSResearch2.SetFilter("No.", '<>%1', Rec."No.");
                BCSResearch2.ModifyAll(Selected, false);
            end;
        }

        field(1000; "Prerequisites"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("BCS Research Prereq." where("Research No." = field("No.")));
            BlankZero = true;
            Editable = true;
        }
        field(1010; "Required By"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("BCS Research Prereq." where(Prerequisite = field("No.")));
            BlankZero = true;
            Editable = true;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    [IntegrationEvent(false, false)]
    local procedure OnAfterResearchProgressComplete(Rec: Record "BCS Research Progress")
    begin
    end;
}
