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
        field(10; "Master Component No."; Code[20])
        {
            //TODO: v0.2 Validate uniqueness
            Caption = 'Master Component No.';
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

    trigger OnInsert()
    var
        ItemBom2: Record "BCS Master Item BOM";
    begin
        if ("Line No." = 0) then begin
            ItemBom2.SetRange("Item No.", "Item No.");
            if ItemBom2.FindLast() then
                "Line No." := ItemBom2."Line No." + 10000
            else
                "Line No." := 10000;
        end;
    end;
}
