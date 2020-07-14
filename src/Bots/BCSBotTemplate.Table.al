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
        field(10; Description; Text[200])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

}