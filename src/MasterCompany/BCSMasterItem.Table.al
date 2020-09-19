table 88010 "BCS Master Item"
{
    Caption = 'BCS Master Item';
    DataClassification = SystemMetadata;
    DrillDownPageId = "BCS Master Item List";
    LookupPageId = "BCS Master Item List";
    DataPerCompany = false;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
        }
        field(10; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(20; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code';
            DataClassification = SystemMetadata;
            TableRelation = "Item Category";
        }
        field(30; "Prod. Posting Group"; Code[20])
        {
            Caption = 'Prod. Posting Group';
            DataClassification = SystemMetadata;
            TableRelation = "Gen. Product Posting Group";
        }

        field(50; "Initial Price"; Decimal)
        {
            Caption = 'Initial Price';
            DataClassification = SystemMetadata;
        }
        field(60; "Available at Start"; Boolean)
        {
            Caption = 'Available at Start';
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
