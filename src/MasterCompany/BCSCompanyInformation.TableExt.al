tableextension 88000 "BCS Company Information" extends "Company Information"
{
    fields
    {
        field(88000; "Master Company"; Boolean)
        {
            Caption = 'Master Company';
            DataClassification = SystemMetadata;
        }
        field(88001; "Current Game Date"; Date)
        {
            Caption = 'Current Game Date';
            DataClassification = SystemMetadata;
            Editable = false;
        }
    }

}