tableextension 88003 "BCS Location" extends Location
{
    fields
    {
        field(88000; "Maximum Units"; Decimal)
        {
            DataClassification = SystemMetadata;
            Caption = 'Maximum Units';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
            //Editable = false;
        }
        field(88001; "Maximum Bots"; Integer)
        {
            DataClassification = SystemMetadata;
            Caption = 'Maximum Bots';
            BlankZero = true;
            //Editable = false;
        }
        field(88002; "Upgrade Code"; Code[20])
        {
            DataClassification = SystemMetadata;
            Caption = 'Upgrade Code';
        }
        field(88100; "Total Stock"; Decimal)
        {
            Caption = 'Maximum Units';
            DecimalPlaces = 0 : 0;
            BlankZero = true;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum ("Item Ledger Entry".Quantity where("Location Code" = field(Code)));
        }
        field(88101; "Assigned Bots"; Integer)
        {
            Caption = 'Assigned Bots';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = count ("BCS Bot Instance" where("Bot Type" = filter("Inventory-Basic" | "Inventory-Advanced"), "Assignment Code" = field(code)));
        }
    }

}