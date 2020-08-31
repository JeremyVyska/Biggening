table 88022 "BCS Bot Template Req."
{
    Caption = 'BCS Bot Template Req.';
    DataClassification = ToBeClassified;
    DataPerCompany = false;

    fields
    {
        field(1; "Bot Template Code"; Code[20])
        {
            Caption = 'Bot Template Code';
            DataClassification = SystemMetadata;
            TableRelation = "BCS Bot Template";
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
            DecimalPlaces = 0 : 0;
        }
    }
    keys
    {
        key(PK; "Bot Template Code", "Line No.")
        {
            Clustered = true;
        }
    }

}
