tableextension 88004 "BCS Customer" extends Customer
{
    fields
    {
        field(88000; "Max Orders Per Day"; Integer)
        {
            Caption = 'Max. Orders Per Day';
            DataClassification = SystemMetadata;
        }
        field(88001; "Max Quantity Per Day"; Integer)
        {
            Caption = 'Max. Quantity Per Day';
            DataClassification = SystemMetadata;
        }
    }
}
