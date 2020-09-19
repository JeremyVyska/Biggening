codeunit 88030 "BCS Season Create"
{
    procedure CreateNewSeason()
    var
        ActiveSeason: Record "BCS Season";
        NewSeason: Record "BCS Season";
    begin
        // Archive all the 'Seasonal' data
        ArchivePlayers(ActiveSeason."No.");
        ArchiveMarketData(ActiveSeason."No.");

        // Clear all the interco operational data
        ClearBotErrorLogs();
        ClearMarketData();

        Commit();

        // Hmm - trying to decide if we should also Handle player company deletion. 
        // that is super DB intensive, but manually doing 40 companies would take ages.



    end;

    local procedure ArchivePlayers(SeasonNo: Integer)
    var
        Player: Record "BCS Player";
        PlayerArc: Record "BCS Player Archive";
    begin
        if Player.FindSet() then
            repeat
                PlayerArc.TransferFields(Player);
                PlayerArc."Season No." := SeasonNo;
                PlayerArc.Insert(true);
            until Player.Next() = 0;
    end;

    local procedure ArchiveMarketData(SeasonNo: Integer)
    var
        MktPrice: Record "BCS Market Price";
        MktPriceArc: Record "BCS Market Price Archive";
        MktTrade: Record "BCS Market Trades";
        MktTradeArc: Record "BCS Market Trades Archive";
    begin
        if MktPrice.FindSet() then
            repeat
                MktPriceArc.TransferFields(MktPrice);
                MktPriceArc."Season No." := SeasonNo;
                MktPriceArc.Insert(true);
            until MktPrice.Next() = 0;
        if MktTrade.FindSet() then
            repeat
                MktTradeArc.TransferFields(MktTrade);
                MktTradeArc."Season No." := SeasonNo;
                MktTradeArc.Insert(true);
            until MktTrade.Next() = 0;
    end;

    local procedure ClearBotErrorLogs()
    var
        BotError: Record "BCS Bot Error Log";
    begin
        BotError.DeleteAll();
    end;

    local procedure ClearMarketData()
    var
        MktPrice: Record "BCS Market Price";
        MktTrade: Record "BCS Market Trades";
    begin
        MktPrice.DeleteAll();
        MktTrade.DeleteAll();
    end;
}
