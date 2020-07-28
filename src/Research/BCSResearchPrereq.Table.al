table 88009 "BCS Research Prereq."
{
    Caption = 'BCS Research Prereq.';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "Research No."; Integer)
        {
            Caption = 'Research No.';
            DataClassification = SystemMetadata;
            TableRelation = "BCS Research";
            BlankZero = true;
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(5; "Requirement Type"; Option)
        {
            Caption = 'Requirement Type';
            DataClassification = SystemMetadata;
            OptionMembers = " ","Research","Material";
            OptionCaption = ' ,Research,Material';
        }
        field(10; Prerequisite; Integer)
        {
            Caption = 'Prerequisite';
            DataClassification = SystemMetadata;
            TableRelation = "BCS Research";
            BlankZero = true;
        }
        field(20; "Master Item No."; Code[20])
        {
            Caption = 'Master Item No.';
            DataClassification = SystemMetadata;
        }
        field(25; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = SystemMetadata;
            BlankZero = true;
        }
    }
    keys
    {
        key(PK; "Research No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if ("Requirement Type" = "Requirement Type"::Research) and (Prerequisite <> 0) then
            CyclicCheck();

    end;

    trigger OnModify()
    begin
        if ("Requirement Type" = "Requirement Type"::Research) and (Prerequisite <> 0) then
            CyclicCheck();
    end;

    local procedure CyclicCheck()
    begin

    end;

    var
        CyclicLoopErr: Label 'There is a looping issue in your selection';
}
