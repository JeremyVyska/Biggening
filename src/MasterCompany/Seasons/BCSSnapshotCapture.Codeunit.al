codeunit 88020 "BCS Snapshot Capture"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCS Player Heartbeat Listener", 'OnHeartbeat', '', true, true)]
    local procedure "BCS Player Heartbeat Listener_OnHeartbeat"()
    begin
        TakeSnapshot();
        GenerateDailyRankings();
    end;

    local procedure TakeSnapshot()
    var
        CompanyInfo: Record "Company Information";
        GLAccount: Record "G/L Account";
        Location: Record Location;
        Customer: Record Customer;
        Vendor: Record Vendor;
        GameSetup: Record "BCS Game Setup";
        Seasons: Record "BCS Season";
        Players: Record "BCS Player";
        Bots: Record "BCS Bot Instance";
        PowerLedger: Record "BCS Power Ledger";
        Snapshot: Record "BCS Snapshot";
        SnapshotBots: Record "BCS Snapshot Bots";
        CurrentBotTypes: List of [Integer];
        i: Integer;
    begin
        GameSetup.Get();
        Seasons.SetRange(Active, true);
        if Seasons.IsEmpty then
            exit
        else
            Seasons.FindLast();
        Players.SetRange("Company Name", CompanyName());
        if Players.IsEmpty then
            exit
        else
            Players.FindFirst();
        if not CompanyInfo.Get() then
            exit;
        if CompanyInfo."Current Game Date" = 0D then
            exit;

        if Snapshot.get(Seasons."No.", Players."No.", CompanyInfo."Current Game Date") then
            exit;

        Snapshot."Season No." := Seasons."No.";
        Snapshot."Player No." := Players."No.";
        Snapshot."Game Date" := CompanyInfo."Current Game Date";

        Snapshot."Location Counts" := Location.Count;
        Snapshot."Customer Counts" := Customer.Count;
        Snapshot."Vendor Counts" := Vendor.Count;

        GLAccount.Get(GameSetup."Wealth Account");
        GLAccount.SetRange("Date Filter", 0D, CalcDate('<-1D>', CompanyInfo."Current Game Date"));
        GLAccount.CalcFields("Net Change", Balance);

        Snapshot."Wealth Balance" := GLAccount.Balance;
        Snapshot."Wealth Net Change" := GLAccount.Balance - GLAccount."Net Change";

        PowerLedger.SetRange("Posting Date", CalcDate('<-1D>', CompanyInfo."Current Game Date"));
        PowerLedger.CalcSums("Power Usage");
        Snapshot."Power Usage" := PowerLedger."Power Usage";

        Snapshot.Insert(true);

        CurrentBotTypes := SnapshotBots."Bot Type".Ordinals();
        foreach i in CurrentBotTypes do begin
            Bots.SetRange("Bot Type", "BCS Bot Type".FromInteger(i));
            SnapshotBots."Season No." := Seasons."No.";
            SnapshotBots."Player No." := Players."No.";
            SnapshotBots."Game Date" := CompanyInfo."Current Game Date";
            SnapshotBots."Bot Type" := "BCS Bot Type".FromInteger(i);
            SnapshotBots."Bot Count" := Bots.Count;
            SnapshotBots.Insert(true);
        end;
    end;

    local procedure GenerateDailyRankings()
    var
        GameSetup: Record "BCS Game Setup";
        Snapshot: Record "BCS Snapshot";
        Rank: Integer;
    begin
        GameSetup.Get();
        Snapshot.SetCurrentKey("Game Date", "Wealth Balance");
        Snapshot.SetAscending("Wealth Balance", false);
        Snapshot.SetRange("Game Date", GameSetup."Game Date");
        if Snapshot.FindSet(true) then
            repeat
                Rank := Rank + 1;
                Snapshot."Rank at Date" := Rank;
                Snapshot.Modify(true);
            until Snapshot.Next() = 0;
    end;

}
