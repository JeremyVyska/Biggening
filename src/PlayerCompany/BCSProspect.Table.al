table 88012 "BCS Prospect"
{
    Caption = 'BCS Prospect';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(2; Type; Option)
        {
            OptionMembers = "Customer","Vendor";
            OptionCaption = 'Customer,Vendor';
            Caption = 'Type';
            DataClassification = SystemMetadata;
        }
        field(10; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(50; "Maximum Orders Per Day"; Decimal)
        {
            Caption = 'Maximum Orders Per Day';
            DataClassification = ToBeClassified;
        }
        field(60; "Maximum Quantity Per Order"; Decimal)
        {
            Caption = 'Maximum Quantity Per Order';
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
