codeunit 88005 "BCS Bot Dispatcher"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCS Player Heartbeat Listener", 'OnHeartbeat', '', true, true)]
    local procedure ProcessBotOperations()
    var
        BotInstance: Record "BCS Bot Instance";
    begin
        // Iterate through all the bot instances
        BotInstance.Reset();

        BotInstance.SetRange("Bot Type", BotInstance."Bot Type"::Purchasing);
        HandleBotsOfType(BotInstance);

        //BotInstance.SetRange("Bot Type",BotInstance."Bot Type"::"Inventory-Basic");
        //HandleBotsOfType(BotInstance);
    end;

    local procedure HandleBotsOfType(var BotInstance: Record "BCS Bot Instance")
    var
        BotActLog: Record "BCS Bot Activity Log";
        BotErrLog: Record "BCS Bot Error Log";
        BotPurchase: Codeunit "BCS Bot Purchase";
    begin
        if BotInstance.FindSet(false) then
            repeat
                case BotInstance."Bot Type" of
                    BotInstance."Bot Type"::Purchasing:
                        begin
                            Commit();
                            Clear(BotPurchase);
                            if BotPurchase.Run(BotInstance) then begin
                                // YAY! It worked
                                // log to the player activity log
                                Clear(BotActLog);
                                BotActLog.Init();
                                BotActLog."Bot Type" := BotInstance."Bot Type";
                                BotActLog."Bot Instance" := BotInstance."Instance ID";
                                BotActLog."Posting Date" := WorkDate();
                                BotActLog.Description := BotPurchase.GetResultText();
                                BotActLog.Insert(true);

                            end else begin
                                // It hit an error
                                // log to the system error log
                                Clear(BotErrLog);
                                BotErrLog.Init();
                                BotErrLog."Company Name" := CompanyName();
                                BotErrLog."Bot Type" := BotInstance."Bot Type";
                                BotErrLog."Bot Instance" := BotInstance."Instance ID";
                                BotErrLog."Posting Date" := WorkDate();
                                //BotErrLog.Description := BotPurchase.GetResultText();
                                BotErrLog."Error Message" := COPYSTR(GetLastErrorText(), 1, MAXSTRLEN(BotErrLog."Error Message"));
                                //TODO: Handle the whole error result with BLOB?
                                BotErrLog.Insert(true);
                            end;
                            Commit();
                        end;

                end;
            until BotInstance.Next() = 0;
    end;
}
