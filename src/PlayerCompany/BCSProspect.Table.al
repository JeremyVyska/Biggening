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
        GameSetup: Record "BCS Game Setup";
        RandomPool: Record "BCS Random Entity Name Pool";
        Trades: Record "BCS Prospect Trades";
    begin
        GameSetup.Get();
        // No, Name, Gen. Bus. Posting, Vendor Posting
        Vendor.Insert(true);
        Vendor.Name := Rec.Name;
        if (Rec."Random Entry Source No." <> 0) and (RandomPool.Get(Rec."Random Entry Source No.")) then begin
            Vendor.Address := RandomPool.Address;
            Vendor.Contact := RandomPool."Contact Name";
            Vendor."E-Mail" := RandomPool.Email;
        end;
        Vendor."Gen. Bus. Posting Group" := Vendor."VAT Bus. Posting Group";
        Vendor."Vendor Posting Group" := GameSetup."Vendor Posting Group";
        Vendor."Payment Method Code" := GameSetup."Vendor Payment Method Code";

        Vendor."Max Orders Per Day" := Rec."Maximum Orders Per Day";
        Vendor."Max Quantity Per Day" := Rec."Maximum Quantity Per Order";
        Vendor.Modify(true);

        //Migrate all trades to Item Vendor
        Trades.SetRange("Prospect No.", Rec."No.");
        if IfSafetyCheckUnresearchedTrades(Trades) then begin
            if Trades.FindSet(false) then
                repeat
                    ItemVendor."Vendor No." := Vendor."No.";
                    ItemVendor."Item No." := Trades."Item No.";
                    ItemVendor.Insert(true);
                until Trades.Next() = 0;
        end else
            Error('');  //Error blank to rollback the transaction with no additional message.
        exit(Vendor."No.");
    end;

    procedure ConvertToCustomer(): Code[20]
    var
        Customer: Record Customer;
        GameSetup: Record "BCS Game Setup";
        CustInterests: Record "BCS Customer Interest";
        RandomPool: Record "BCS Random Entity Name Pool";
        Trades: Record "BCS Prospect Trades";
    begin
        GameSetup.Get();
        // No, Name, Gen. Bus. Posting, Customer Posting
        Customer.Insert(true);
        Customer.Name := Rec.Name;
        if (Rec."Random Entry Source No." <> 0) and (RandomPool.Get(Rec."Random Entry Source No.")) then begin
            Customer.Address := RandomPool.Address;
            Customer.Contact := RandomPool."Contact Name";
            Customer."E-Mail" := RandomPool.Email;
        end;
        Customer."Gen. Bus. Posting Group" := GameSetup."Customer Bus. Posting Group";
        Customer."Customer Posting Group" := GameSetup."Customer Posting Group";
        Customer."Payment Method Code" := GameSetup."Customer Payment Method Code";
        Customer.Modify(true);

        //Migrate all trades to Customer Interests
        Trades.SetRange("Prospect No.", Rec."No.");
        if IfSafetyCheckUnresearchedTrades(Trades) then begin
            if Trades.FindSet(false) then
                repeat
                    CustInterests."Customer No." := Customer."No.";
                    CustInterests."Item Category Code" := Trades."Item Category Code";
                    CustInterests."Prod. Posting Group" := Trades."Prod. Posting Group";
                    CustInterests.Insert(true);
                until Trades.Next() = 0;
        end else
            Error('');  //Error blank to rollback the transaction with no additional message.
        exit(Customer."No.");
    end;

    local procedure IfSafetyCheckUnresearchedTrades(Trades: Record "BCS Prospect Trades"): Boolean
    var
        Item: Record Item;
        MissingItems: Boolean;
        UnresearchedWarningQst: Label 'This Prospect has Trades that are for items you have not yet unlocked through research. Converting them will remove those trades.\ \Proceed?';
    begin
        if Trades.FindSet() then
            repeat
                if not MissingItems then
                    if not Item.get(Trades."Item No.") then
                        MissingItems := true;
            until Trades.Next() = 0;
        if MissingItems then
            exit(Confirm(UnresearchedWarningQst, false));
    end;
}
