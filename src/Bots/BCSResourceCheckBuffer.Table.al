table 88023 "BCS Resource Check Buffer"
{
    Caption = 'BCS Resource Check Buffer';
    DataClassification = ToBeClassified;
    
    fields
    {
        field(1; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(10; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = SystemMetadata;
        }
        field(20; Requirement; Decimal)
        {
            Caption = 'Requirement';
            DataClassification = SystemMetadata;
        }
        field(30; Inventory; Decimal)
        {
            Caption = 'Inventory';
            DataClassification = SystemMetadata;
        }
        field(50; Shortage; Boolean)
        {
            Caption = 'Shortage';
            DataClassification = SystemMetadata;
        }
        field(60; LineStyle; Text[100])
        {
            Caption = 'LineStyle';
            DataClassification = SystemMetadata;
        }
    }
    keys
    {
        key(PK; "Line No.")
        {
            Clustered = true;
        }
    }
    
}
