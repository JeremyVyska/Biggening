codeunit 88031 "BCS Player Starting Values"
{
    trigger OnRun()
    begin
        GameSetup.Get();

        // We need a basic Company Information.  Doesn't need to be much, but must exist
        GenerateCompanyInfo();

        // Game setup - initial Cash, basic locations
        GivePlayerStartingCash();
        CreateLocations();

        // Master items - copy items 'Available at start'
        CopyInitMasterItems();

        // Initial Customer & Vendor for Lowest Price starter item
        SetupInitCustomer();
        SetupInitVendor();

        // Bots - instantiate bots based on count of 'Include at start' on Templates
        FindAndBuyStarterBots();

        // Last step, update the Player record for this company
        UpdatePlayerAsDone();
    end;

    local procedure ChargeThePlayer(ChargeAcct: Code[20]; AmountToCharge: Decimal)
    var
        PlayerCharge: Codeunit "BCS Player Charge";
        InitChargeTok: Label 'Company Initial Values';
    begin
        PlayerCharge.ChargeCash(ChargeAcct, AmountToCharge, 'INIT', InitChargeTok);
    end;

    local procedure GivePlayerStartingCash()
    begin
        if (GameSetup."Starting Cash" <> 0) and (HasZeroCash(GameSetup."Starting Balance Account")) then
            // Note the sign flip - we're -reverse- charging cash to initialize.
            ChargeThePlayer(GameSetup."Starting Balance Account", -GameSetup."Starting Cash");
    end;

    local procedure CreateLocations()
    var
        LocPurchase: Codeunit "BCS Location Management";
        Locations: Record Location;
        i: Integer;
    begin
        if not Locations.IsEmpty then
            exit;
        if (GameSetup."Starting Basic Locations" <> 0) then begin
            // Give the player the initial money for the locations - Note, ChargeThePlayer calls COMMIT!
            ChargeThePlayer(GameSetup."Starting Balance Account",
                -(GameSetup."Starting Basic Locations" * GameSetup."Basic Location Price"));

            // And now we can just 'buy' the locations using existing code.  Tidy.
            for i := 1 to GameSetup."Starting Basic Locations" do
                LocPurchase.PurchaseLocation(true);  //almost a palindrome.  naming Method CUs is odd.
        end;
    end;

    local procedure CopyInitMasterItems()
    var
        MasterItem: Record "BCS master item";
        Item: Record Item;
        ItemUOM: Record "Item Unit of Measure";
    begin
        MasterItem.SetRange("Available at Start", true);
        if MasterItem.FindSet() then
            repeat
                if not Item.Get(MasterItem."No.") then begin
                    Item.Reset();
                    Item."No." := MasterItem."No.";
                    Item.Validate(Description, MasterItem.Description);
                    Item.Insert(true);   // (╯°□°）╯︵ ┻━┻
                    // Debugged a bit - It's NOT actually creating the Item UOM, which fails during the Item Vendor creation
                    Item.Validate("Base Unit of Measure", GameSetup."System Unit of Measure");
                    Item.Validate("Gen. Prod. Posting Group", MasterItem."Prod. Posting Group");
                    Item.Validate("Item Category Code", MasterItem."Item Category Code");
                    Item.Modify(true);   // ಠ_ಠ

                    // So we'll make sure we make it, that's fine.
                    ItemUOM.Init();
                    ItemUOM."Item No." := Item."No.";
                    ItemUOM.Code := GameSetup."System Unit of Measure";
                    ItemUOM.Insert(true);   //???????? 
                end;
            until MasterItem.Next() = 0;
    end;

    local procedure FindAndBuyStarterBots()
    var
        BotTemplate: Record "BCS Bot Template";
        Bot: Record "BCS Bot Instance";
        PurchBot: Codeunit "BCS Bot Management";
        i: Integer;
    begin
        GameSetup.Get();
        BotTemplate.SetFilter("Start With", '>0');
        if BotTemplate.FindSet() then
            repeat
                for i := 1 to BotTemplate."Start With" do begin
                    Bot.SetRange("Bot Template Code", BotTemplate.Code);
                    if Bot.Count() <> BotTemplate."Start With" then begin
                        // Give the player the initial cash for the bot in question (sign flip!)
                        ChargeThePlayer(GameSetup."Starting Balance Account", -BotTemplate."Base Price");
                        // Then execute the purchase
                        PurchBot.InitialPurchaseBot(BotTemplate.Code);
                    end;
                end;
            until BotTemplate.Next() = 0;
    end;

    local procedure UpdatePlayerAsDone()
    var
        Player: Record "BCS Player";
    begin
        Player.SetRange("Company Name", CompanyName());
        if Player.FindFirst() then begin
            Player."Step - Init. Job Ran" := true;
            Player.Modify();
        end;
    end;

    local procedure GenerateCompanyInfo()
    var
        CompanyInfo: Record "Company Information";
        Company: Record Company;
    begin
        if not CompanyInfo.get() then begin
            CompanyInfo.Insert(true);
            Company.Get(CompanyName());
            if Company."Display Name" <> '' then
                CompanyInfo.Name := CopyStr(Company."Display Name", 1, MaxStrLen(CompanyInfo.Name))
            else
                CompanyInfo.Name := Company.Name;
            CompanyInfo.Modify(true);
        end;
        GameSetup.Get();
        CompanyInfo.Get();
        CompanyInfo."Current Game Date" := GameSetup."Game Date";
        CompanyInfo.Modify(true);
    end;

    local procedure SetupInitCustomer()
    var
        Customer: Record Customer;
        MasterItem: Record "BCS Master Item";
        CustInterests: Record "BCS Customer Interest";
        RandomPool: Record "BCS Random Entity Name Pool";
    begin
        if not Customer.IsEmpty then
            exit;
        GameSetup.Get();

        if not RandomPool.FindFirst() then
            Error('');
        RandomPool.Next(Random(RandomPool.Count) - 1);

        // No, Name, Gen. Bus. Posting, Customer Posting
        Customer.Insert(true);
        Customer.Name := RandomPool."Company Name";
        Customer.Address := RandomPool.Address;
        Customer.Contact := RandomPool."Contact Name";
        Customer."E-Mail" := CopyStr(RandomPool.Email, 1, MaxStrLen(Customer."E-Mail"));
        Customer."Gen. Bus. Posting Group" := GameSetup."Customer Bus. Posting Group";
        Customer."Customer Posting Group" := GameSetup."Customer Posting Group";
        Customer."Payment Method Code" := CopyStr(GameSetup."Customer Payment Method Code", 1, MaxStrLen(Customer."Payment Method Code"));
        Customer.Modify(true);

        // find cheapest item
        MasterItem.SetRange("Available at Start", true);
        MasterItem.SetCurrentKey("Initial Price");
        MasterItem.FindFirst();

        // and make that the trade.
        CustInterests."Customer No." := Customer."No.";
        CustInterests."Item Category Code" := MasterItem."Item Category Code";
        CustInterests."Prod. Posting Group" := MasterItem."Prod. Posting Group";
        CustInterests.Insert(true);
    end;

    local procedure SetupInitVendor()
    var
        Vendor: Record Vendor;
        ItemVendor: Record "Item Vendor";
        MasterItem: Record "BCS Master Item";
        RandomPool: Record "BCS Random Entity Name Pool";
    begin
        if not Vendor.IsEmpty then
            exit;
        GameSetup.Get();

        if not RandomPool.FindFirst() then
            Error('');
        RandomPool.Next(Random(RandomPool.Count) - 1);

        // No, Name, Gen. Bus. Posting, Vendor Posting
        Vendor.Insert(true);
        Vendor.Name := RandomPool."Company Name";
        Vendor.Address := RandomPool.Address;
        Vendor.Contact := RandomPool."Contact Name";
        Vendor."E-Mail" := CopyStr(RandomPool.Email, 1, MaxStrLen(Vendor."E-Mail"));
        Vendor."Gen. Bus. Posting Group" := GameSetup."Vendor Bus. Posting Group";
        Vendor."Vendor Posting Group" := GameSetup."Vendor Posting Group";
        Vendor."Payment Method Code" := CopyStr(GameSetup."Vendor Payment Method Code", 1, MaxStrLen(Vendor."Payment Method Code"));

        Vendor."Max Orders Per Day" := Round(GameSetup."Purch. Pros. Base Max Orders" * GameSetup."Purch. Pros. Tier Multiplier");
        Vendor."Max Quantity Per Day" := Round(GameSetup."Purch. Pros. Base Max Quantity" * GameSetup."Purch. Pros. Tier Multiplier");

        Vendor.Modify(true);

        // First vendor sells a little of everything
        MasterItem.SetRange("Available at Start", true);
        if MasterItem.FindSet() then
            repeat
                ItemVendor."Vendor No." := Vendor."No.";
                ItemVendor."Item No." := MasterItem."No.";
                ItemVendor.Insert(true);
            until MasterItem.Next() = 0;
    end;

    local procedure HasZeroCash(StartingBalanceAccount: Code[20]): Boolean
    var
        GLAccount: Record "G/L Account";
    begin
        GLAccount.Get(StartingBalanceAccount);
        GLAccount.CalcFields(Balance);
        exit(GLAccount.Balance = 0);
    end;





    var
        GameSetup: Record "BCS Game Setup";
}
