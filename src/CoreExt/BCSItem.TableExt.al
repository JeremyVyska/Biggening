tableextension 88002 "BCS Item" extends Item
{
    fields
    {
        field(88000; "BCS Reorder Level"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Reorder Level';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }
        field(88001; "BCS Maximum Stock"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Maximum Stock';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }
        field(88002; "BCS Max. Purch Price."; Decimal)
        {
            Caption = 'BCS Max. Purch Price.';
            DataClassification = SystemMetadata;
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }
        field(88010; "BCS Min. Sales Price."; Decimal)
        {
            Caption = 'BCS Min. Sales Price.';
            DataClassification = SystemMetadata;
            DecimalPlaces = 0 : 0;
            BlankZero = true;
        }
    }

    var
        myInt: Integer;
}