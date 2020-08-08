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
    }

    var
        myInt: Integer;
}