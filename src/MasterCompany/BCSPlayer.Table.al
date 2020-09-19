table 88015 "BCS Player"
{
    Caption = 'BCS Player';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(5; "Name"; Text[100])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
        field(10; "Email"; Text[200])
        {
            Caption = 'Email';
            DataClassification = SystemMetadata;
        }
        field(40; "User Name"; Code[50])
        {
            Caption = 'User Name';
            DataClassification = SystemMetadata;
        }
        field(50; "User ID"; Guid)
        {
            Caption = 'User ID';
            DataClassification = SystemMetadata;
            TableRelation = User;
        }
        field(60; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            DataClassification = SystemMetadata;
            TableRelation = Company;
            ValidateTableRelation = false;
        }
        field(70; "System Permissions"; Option)
        {
            Caption = 'System Permissions';
            DataClassification = SystemMetadata;
            OptionMembers = "Player","Admin";
            OptionCaption = 'Player,Admin';
        }

        field(1000; "Company Display Name"; Text[80])
        {
            Caption = 'Company Display Name';
            FieldClass = FlowField;
            CalcFormula = lookup (Company."Display Name" where(Name = field("Company Name")));
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
