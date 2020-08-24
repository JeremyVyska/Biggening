table 88012 "BCS Prospect"
{
    Caption = 'BCS Prospect';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "No."; Integer)
        {
            Caption = 'No.';
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; Type; Option)
        {
            OptionMembers = "Customer","Vendor";
            OptionCaption = 'Customer,Vendor';
            Caption = 'Type';
            DataClassification = SystemMetadata;
        }
        field(10; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = SystemMetadata;
        }
        field(50; "Maximum Orders Per Day"; Decimal)
        {
            Caption = 'Maximum Orders Per Day';
            DataClassification = SystemMetadata;
        }
        field(60; "Maximum Quantity Per Order"; Decimal)
        {
            Caption = 'Maximum Quantity Per Order';
            DataClassification = SystemMetadata;
        }
        field(80; "Random Entry Source No."; Integer)
        {
            Caption = 'Random Entry Source No.';
            DataClassification = SystemMetadata;
            TableRelation = "BCS Random Entity Name Pool";
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    procedure ConvertToVendor(): Code[20]
    var
        Vendor: Record Vendor;
        ItemVendor: Record "Item Vendor";
        RandomPool: Record "BCS Random Entity Name Pool";
        Trades: Record "BCS Prospect Trades";
    begin
        // No, Name, Gen. Bus. Posting, Vendor Posting
        Vendor.Insert(true);
        Vendor.Name := Rec.Name;
        if (Rec."Random Entry Source No." <> 0) and (RandomPool.Get(Rec."Random Entry Source No.")) then begin
            Vendor.Address := RandomPool.Address;
            Vendor.Contact := RandomPool."Contact Name";
            Vendor."E-Mail" := RandomPool.Email;
        end;
        //TODO: These should come from Game Setup
        Vendor."Gen. Bus. Posting Group" := 'TIER1';
        Vendor."Vendor Posting Group" := 'VEND';
        Vendor."Payment Method Code" := 'AUTOPAY';

        Vendor."Max Orders Per Day" := Rec."Maximum Orders Per Day";
        Vendor."Max Quantity Per Day" := Rec."Maximum Quantity Per Order";
        Vendor.Modify(true);

        //Migrate all trades to Item Vendor
        Trades.SetRange("Prospect No.", Rec."No.");
        if Trades.FindSet(false) then
            repeat
                ItemVendor."Vendor No." := Vendor."No.";
                ItemVendor."Item No." := Trades."Item No.";
                ItemVendor.Insert(true);
            until Trades.Next() = 0;

        exit(Vendor."No.");
    end;

    procedure ConvertToCustomer(): Code[20]
    var
        Customer: Record Customer;
        CustInterests: Record "BCS Customer Interest";
        RandomPool: Record "BCS Random Entity Name Pool";
        Trades: Record "BCS Prospect Trades";
    begin
        // No, Name, Gen. Bus. Posting, Customer Posting
        Customer.Insert(true);
        Customer.Name := Rec.Name;
        if (Rec."Random Entry Source No." <> 0) and (RandomPool.Get(Rec."Random Entry Source No.")) then begin
            Customer.Address := RandomPool.Address;
            Customer.Contact := RandomPool."Contact Name";
            Customer."E-Mail" := RandomPool.Email;
        end;
        //TODO: These should come from Game Setup
        Customer."Gen. Bus. Posting Group" := 'TIER1';
        Customer."Customer Posting Group" := 'CUST';
        Customer."Payment Method Code" := 'AUTOPAY';
        Customer.Modify(true);

        //Migrate all trades to Customer Interests
        Trades.SetRange("Prospect No.", Rec."No.");
        if Trades.FindSet(false) then
            repeat
                CustInterests."Customer No." := Customer."No.";
                CustInterests."Item Category Code" := Trades."Item Category Code";
                CustInterests."Prod. Posting Group" := Trades."Prod. Posting Group";
                CustInterests.Insert(true);
            until Trades.Next() = 0;

        exit(Customer."No.");
    end;
}
