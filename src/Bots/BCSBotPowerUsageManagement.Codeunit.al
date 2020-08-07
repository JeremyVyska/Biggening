codeunit 88004 "BCS Bot Power Usage Management"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCS Player Heartbeat Listener", 'OnHeartbeat', '', true, true)]
    local procedure ChargeBotPowerUsage()
    var
        BotInstance: Record "BCS Bot Instance";
        PowerLedger: Record "BCS Power Ledger";
    begin
        // Iterate through all the bot instances
        BotInstance.Reset();
        if BotInstance.FindSet(false) then

            // for each
            repeat
                //Calculate the total power usage


                //Create a power usage ledger 
                Clear(PowerLedger);
                PowerLedger.Init();
                PowerLedger."Bot Instance" := BotInstance."Instance ID";
                PowerLedger."Bot Type" := BotInstance."Bot Type";
                PowerLedger."Posting Date" := WorkDate();
                PowerLedger."Power Usage" := BotInstance.GetPowerPerDay();
                PowerLedger."Posted to G/L" := false;
                PowerLedger.Insert(true);
            until BotInstance.Next() = 0;
    end;
}