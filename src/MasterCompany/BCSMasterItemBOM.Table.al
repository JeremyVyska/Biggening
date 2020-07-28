table 88011 "BCS Master Item BOM"
{
    Caption = 'BCS Master Item BOM';
    DataClassification = SystemMetadata;
    DataPerCompany = false;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = SystemMetadata;
            TableRelation = "BCS Master Item";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = SystemMetadata;
        }
        field(10; "Master Item No."; Code[20])
        {
            Caption = 'Master Item No.';
            DataClassification = SystemMetadata;
            TableRelation = "BCS Master Item";
        }
        field(20; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = SystemMetadata;
            BlankZero = true;
        }
    }
    keys
    {
        key(PK; "Item No.", "Line No.")
        {
            Clustered = true;
        }
    }

}
