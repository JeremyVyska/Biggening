codeunit 88021 "BCS Market Calculation"
{
    // Price recalc master engine

    procedure CalculateDailyPrices()
    var
        GameSetup: Record "BCS Game Setup";
        MasterItem: Record "BCS Master Item";
        MarketPrice: Record "BCS Market Price";
        MarketTrades: Record "BCS Market Trades";
        Players: Record "BCS Player";
        priorDayTrades: Decimal;
        earlierTrades: Decimal;
        marketMovement: Decimal;
    begin
        GameSetup.Get();
        // Never calc the same day twice
        MarketPrice.SetRange("Last Calculated", WorkDate());
        if not MarketPrice.IsEmpty then
            exit;

        if MasterItem.FindSet() then
            repeat
                MarketTrades.SetRange("Item No.", MasterItem."No.");
                MarketTrades.SetRange(Date, CalcDate('<-2D>', WorkDate()));
                if MarketTrades.FindFirst() then
                    earlierTrades := MarketTrades."Total Trades";
                MarketTrades.SetRange(Date, CalcDate('<-1D>', WorkDate()));
                if MarketTrades.FindFirst() then
                    priorDayTrades := MarketTrades."Total Trades";

                // Trading Volume difference / # of Players (if not zero)
                // 2000 - 1000 / 10   = 100
                // 1000 - 2000 / 10   = -100
                if (Players.Count = 0) then
                    exit;

                // Super safety check on these GameSetup options
                if GameSetup."Market Move Multiplier" = 0 then
                    GameSetup."Market Move Multiplier" := 0.5;
                if GameSetup."Market Movement Floor" = 0 then
                    GameSetup."Market Movement Floor" := 20;

                marketMovement := priorDayTrades - earlierTrades / Players.count;
                if (marketMovement < 0) then
                    marketMovement := marketMovement * GameSetup."Market Move Multiplier";

                if (marketMovement = 0) then
                    marketMovement := GameSetup."Market Movement Floor";

                MarketPrice.Reset();
                if not MarketPrice.Get(MasterItem."No.") then begin
                    // first time safety catch
                    MarketPrice."Item No." := MasterItem."No.";
                    MarketPrice."Last Calculated" := WorkDate();
                    MarketPrice."Market Price" := MasterItem."Initial Price";
                    MarketPrice.Insert(true);
                end else begin
                    MarketPrice."Market Price" := MarketPrice."Market Price" * (1 + (marketMovement / 100));
                    MarketPrice."Last Calculated" := WorkDate();
                    MarketPrice.Modify(true);
                end;
                SafeStoreMarketPrice(MasterItem."No.", MarketPrice."Market Price");
            until MasterItem.Next() = 0;
    end;

    procedure GetMarketPrice(ItemNo: Code[20]): Decimal
    var
        MarketPrice: Record "BCS Market Price";
    begin
        if MarketPrice.Get(ItemNo) then
            exit(MarketPrice."Market Price");
        exit(0);
    end;

    procedure SafeStoreMarketPrice(ItemNo: Code[20]; Price: Decimal)
    var
        Player: Record "BCS Player";
        MarketTrades: Record "BCS Market Trades";
    begin
        MarketTrades.SetRange("Item No.", ItemNo);
        MarketTrades.SetRange(Date, WorkDate());
        if Player.FindSet() then
            repeat
                MarketTrades.SetRange(Company, Player."Company Name");
                if not MarketTrades.FindFirst() then begin
                    MarketTrades."Item No." := ItemNo;
                    MarketTrades.Date := WorkDate();
                    MarketTrades.Company := Player."Company Name";
                    MarketTrades.Price := Price;
                    MarketTrades.Insert(true);
                end else begin
                    MarketTrades.Price := Price;
                    MarketTrades.Modify(true);
                end;
            until Player.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCS Master Heartbeat", 'OnMasterHeartbeat', '', true, true)]
    local procedure "BCS Master Heartbeat_OnMasterHeartbeat"()
    begin
        CalculateDailyPrices();
    end;

}
