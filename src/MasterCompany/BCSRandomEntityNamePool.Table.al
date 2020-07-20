table 88003 "BCS Random Entity Name Pool"
{
    DataClassification = SystemMetadata;
    DataPerCompany = false;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(10; "Company Name"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Company Name';
        }

        field(20; "Contact Name"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Contact Name';
        }
        field(21; "Email"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Email';
        }
        field(22; "Address"; Text[100])
        {
            DataClassification = SystemMetadata;
            Caption = 'Address';
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

}