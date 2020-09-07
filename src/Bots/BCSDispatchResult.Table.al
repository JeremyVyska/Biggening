table 88025 "BCS Dispatch Result"
{
    Caption = 'BCS Dispatch Result';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(10; ResultText; Text[200])
        {
            Caption = 'ResultText';
            DataClassification = SystemMetadata;
        }
        field(20; "Action Type"; enum "BCS Bot Result Type")
        {
            Caption = 'Action Type';
            DataClassification = SystemMetadata;
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
