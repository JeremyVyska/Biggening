codeunit 88021 "BCS Market Calculation"
{
    // Price recalc master engine

    procedure CalculateDailyPrices()
    var
        MasterItem: Record "BCS Master Item";
        MarketPrice: Record "BCS Market Price";
        MarketTrades: Record "BCS Market Trades";
        Players: Record "BCS Player";
        priorDayTrades: Decimal;
        earlierTrades: Decimal;
        marketMovement: Decimal;
    begin
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

                marketMovement := priorDayTrades - earlierTrades / Players.count;
                if (marketMovement < 0) then
                    marketMovement := marketMovement * 0.5;

                if (marketMovement = 0) then
                    marketMovement := 20;
                //TODO: Game setup settings

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
            until MasterItem.Next() = 0;
    end;



    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCS Master Heartbeat", 'OnMasterHeartbeat', '', true, true)]
    local procedure "BCS Master Heartbeat_OnMasterHeartbeat"()
    begin
        CalculateDailyPrices();
    end;

}
