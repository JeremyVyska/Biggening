table 88024 "BCS Master Tables"
{
    Caption = 'BCS Master Tables';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "Table No."; Integer)
        {
            Caption = 'Table No.';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Table No.")
        {
            Clustered = true;
        }
    }

}
