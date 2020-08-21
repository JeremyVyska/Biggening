table 88020 "BCS Customer Interest"
{
    Caption = 'BCS Customer Interest';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = SystemMetadata;
            TableRelation = Customer;
        }
        field(2; "Prod. Posting Group"; Code[20])
        {
            Caption = 'Prod. Posting Group';
            DataClassification = SystemMetadata;
            TableRelation = "Gen. Product Posting Group";
        }
        field(3; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = SystemMetadata;
            TableRelation = "Item Category";
        }
    }
    keys
    {
        key(PK; "Customer No.", "Prod. Posting Group", "Item Category Code")
        {
            Clustered = true;
        }
    }

}
