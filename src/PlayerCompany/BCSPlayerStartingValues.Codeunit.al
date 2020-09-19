codeunit 88031 "BCS Player Starting Values"
{
    trigger OnRun()
    begin
        GameSetup.Get();

        // Game setup - initial Cash, basic locations
        GivePlayerStartingCash();
        CreateLocations();

        // Master items - copy items 'Available at start'
        CopyInitMasterItems();

        // Bots - instantiate bots based on count of 'Include at start' on Templates
        FindAndBuyStarterBots();
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
        if GameSetup."Starting Cash" <> 0 then begin
            // Note the sign flip - we're -reverse- charging cash to initialize.
            ChargeThePlayer(GameSetup."Starting Balance Account", -GameSetup."Starting Cash");
        end;
    end;

    local procedure CreateLocations()
    var
        LocPurchase: Codeunit "BCS Location Management";
        i: Integer;
    begin
        if GameSetup."Starting Basic Locations" <> 0 then begin
            // Give the player the initial money for the locations
            ChargeThePlayer(GameSetup."Starting Balance Account",
                -(GameSetup."Starting Basic Locations" * GameSetup."Basic Location Price"));

            // And now we can just 'buy' the locations using existing code.  Tidy.
            for i := 1 to GameSetup."Starting Basic Locations" do begin
                LocPurchase.PurchaseLocation(true);  //almost a palindrome.  naming Method CUs is odd.
            end;
        end;
    end;

    local procedure CopyInitMasterItems()
    var
        MasterItem: Record "BCS master item";
        Item: Record Item;
    begin
        MasterItem.SetRange("Available at Start", true);
        if MasterItem.FindSet() then
            repeat
                Item.Reset();
                Item.Validate("No.", MasterItem."No.");
                Item.Validate(Description, MasterItem.Description);
                //This validate autogenerates the Item UOM entry as Qty for us. Handy!
                Item.Validate("Base Unit of Measure", GameSetup."System Unit of Measure");
                Item.Validate("Gen. Prod. Posting Group", MasterItem."Prod. Posting Group");
                Item.Validate("Item Category Code", MasterItem."Item Category Code");
                Item.Insert(true);
            until MasterItem.Next() = 0;
    end;

    local procedure FindAndBuyStarterBots()
    var
        GameSetup: Record "BCS Game Setup";
        BotTemplate: Record "BCS Bot Template";
        PurchBot: Codeunit "BCS Bot Management";
        i: Integer;
    begin
        GameSetup.Get();
        BotTemplate.SetFilter("Start With", '>0');
        if BotTemplate.FindSet() then
            repeat
                for i := 1 to BotTemplate."Start With" do begin
                    // Give the player the initial cash for the bot in question (sign flip!)
                    ChargeThePlayer(GameSetup."Starting Balance Account", -BotTemplate."Base Price");
                    // Then execute the purchase
                    PurchBot.InitialPurchaseBot(BotTemplate.Code);
                end;
            until BotTemplate.Next() = 0;
    end;





    var
        GameSetup: Record "BCS Game Setup";
}
