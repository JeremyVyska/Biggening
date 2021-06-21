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


        // I could have done this via a setup subtable with an extensible enum,
        // but simple list of boolean fields feels ok for now.
        field(100; "Step - Company Made"; Boolean)
        {
            Caption = 'Company Made';
            DataClassification = SystemMetadata;
        }
        field(110; "Step - User Made"; Boolean)
        {
            Caption = 'User Made';
            DataClassification = SystemMetadata;
        }
        field(120; "Step - Job Queues Made"; Boolean)
        {
            Caption = 'Job Queues Made';
            DataClassification = SystemMetadata;
        }
        field(130; "Step - Master Data Copy"; Boolean)
        {
            Caption = 'Master Data Copied';
            DataClassification = SystemMetadata;
        }
        field(150; "Step - Init. Job Ran"; Boolean)
        {
            Caption = 'Init. Job Ran';
            DataClassification = SystemMetadata;
        }

        field(1000; "Company Display Name"; Text[80])
        {
            Caption = 'Company Display Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Company."Display Name" where(Name = field("Company Name")));
        }
        field(1010; "Current Rank"; Integer)
        {
            Caption = 'Current Rank';
            FieldClass = FlowField;
            CalcFormula = lookup("BCS Snapshot"."Rank at Date" where("Season No." = field("Season Filter"), "Game Date" = field("Game Date Filter")));
        }

        field(1100; "Season Filter"; Integer)
        {
            Caption = 'Season Filter';
            FieldClass = FlowFilter;
        }

        field(1110; "Game Date Filter"; Date)
        {
            Caption = 'Game Date Filter';
            FieldClass = FlowFilter;
        }

        field(5000; "Wealth"; Decimal)
        {
            Caption = 'Wealth';
            //Note that this will be a CALCULATED value in boxes, not a static value.
            //It will be kept updated by an Event on the G/L Entry table.
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
