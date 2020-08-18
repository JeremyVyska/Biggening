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
        field(88002; "Purchase Prospect Effort"; Integer)
        {
            Caption = 'Purchase Prospect Effort';
            DataClassification = SystemMetadata;
            Editable = false;
        }
        field(88003; "Sales Prospect Effort"; Integer)
        {
            Caption = 'Sales Prospect Effort';
            DataClassification = SystemMetadata;
            Editable = false;
        }
    }

}