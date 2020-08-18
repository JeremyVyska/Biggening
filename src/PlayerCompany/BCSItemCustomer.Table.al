table 88019 "BCS Item Customer"
{
    Caption = 'BCS Item Customer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            NotBlank = true;
            TableRelation = Item;
        }
        field(2; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            NotBlank = true;
            TableRelation = Customer;
        }
        field(7; "Customer Item No."; Text[50])
        {
            Caption = 'Customer Item No.';
        }
        field(5700; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
    }

    keys
    {
        key(Key1; "Customer No.", "Item No.", "Variant Code")
        {
            Clustered = true;
        }
        key(Key2; "Item No.", "Variant Code", "Customer No.")
        {
        }
        key(Key3; "Customer No.", "Customer Item No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Customer No.", "Item No.", "Variant Code")
        {
        }
    }

    trigger OnDelete()
    begin
        DeleteItemCrossReference;
    end;

    trigger OnInsert()
    begin
        InsertItemCrossReference;
    end;

    trigger OnModify()
    begin
        UpdateItemCrossReference;
    end;

    trigger OnRename()
    begin
        UpdateItemCrossReference;
    end;

    var
        Cust: Record Customer;
        ItemCrossReference: Record "Item Cross Reference";
        DistIntegration: Codeunit "Dist. Integration";
        LeadTimeMgt: Codeunit "Lead-Time Management";

    local procedure InsertItemCrossReference()
    begin
        // Cross-Reference Sync not needed at this time.
    end;

    local procedure DeleteItemCrossReference()
    begin
        // Cross-Reference Sync not needed at this time.
    end;

    local procedure UpdateItemCrossReference()
    begin
        // Cross-Reference Sync not needed at this time.
    end;

}
