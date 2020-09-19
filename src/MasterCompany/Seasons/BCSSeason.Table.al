table 88016 "BCS Season"
{
    Caption = 'BCS Season';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(5; Active; Boolean)
        {
            Caption = 'Active';
            DataClassification = SystemMetadata;
            //            Editable = false;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(20; "Built On Version"; Text[30])
        {
            Caption = 'Built On Version';
            DataClassification = SystemMetadata;
        }
        field(30; Participants; Integer)
        {
            Caption = 'Participants';
            DataClassification = ToBeClassified;
        }
        field(50; "Season Start Date"; Date)
        {
            Caption = 'Season Start Date';
            DataClassification = ToBeClassified;
        }
        field(60; "Season End Date"; Date)
        {
            Caption = 'Season End Date';
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

}
