codeunit 88005 "BCS Bot Dispatcher"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCS Player Heartbeat Listener", 'OnHeartbeat', '', true, true)]
    local procedure ProcessBotOperations()
    var
        BotInstance: Record "BCS Bot Instance";
    begin
        // Iterate through all the bot instances
        BotInstance.Reset();
        BotInstance.SetCurrentKey("Bot Type", "Bot Tier");
        BotInstance.SetAscending("Bot Tier", false);

        BotInstance.SetRange("Bot Type", BotInstance."Bot Type"::"Inventory-Basic");
        HandleBotsOfType(BotInstance);

        BotInstance.SetRange("Bot Type", BotInstance."Bot Type"::"Inventory-Advanced");
        HandleBotsOfType(BotInstance);

        BotInstance.SetRange("Bot Type", BotInstance."Bot Type"::Assembly);
        HandleBotsOfType(BotInstance);

        BotInstance.SetRange("Bot Type", BotInstance."Bot Type"::Manufacturing);
        HandleBotsOfType(BotInstance);

        BotInstance.SetRange("Bot Type", BotInstance."Bot Type"::Sales);
        HandleBotsOfType(BotInstance);

        BotInstance.SetRange("Bot Type", BotInstance."Bot Type"::Purchasing);
        HandleBotsOfType(BotInstance);

        BotInstance.SetRange("Bot Type", BotInstance."Bot Type"::Research);
        HandleBotsOfType(BotInstance);

        BotInstance.SetRange("Bot Type", BotInstance."Bot Type"::Marketing);
        HandleBotsOfType(BotInstance);

    end;

    local procedure HandleBotsOfType(var BotInstance: Record "BCS Bot Instance")
    var
        DispatchResult: Record "BCS Dispatch Result" temporary;
        BotSales: Codeunit "BCS Bot Sales";
        BotPurchase: Codeunit "BCS Bot Purchase";
        BotInvBasic: Codeunit "BCS Bot Inv-Basic";
        BotInvAdv: Codeunit "BCS Bot Inv-Adv";
        BotAssem: Codeunit "BCS Bot Assembly";
        BotManuf: Codeunit "BCS Bot Manuf.";
        BotResearch: Codeunit "BCS Bot Research";
        BotMarketing: Codeunit "BCS Bot Marketing";
    begin
        if BotInstance.FindSet(false) then
            repeat
                Commit();
                case BotInstance."Bot Type" of
                    BotInstance."Bot Type"::Sales:
                        begin
                            Clear(BotSales);
                            if BotSales.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                BotSales.GetResult(DispatchResult);
                                LogActivity(BotInstance, DispatchResult);
                            end else
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                        end;

                    BotInstance."Bot Type"::Purchasing:
                        begin
                            Clear(BotPurchase);
                            if BotPurchase.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                BotPurchase.GetResult(DispatchResult);
                                LogActivity(BotInstance, DispatchResult);
                            end else
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                        end;
                    BotInstance."Bot Type"::"Inventory-Basic":
                        begin
                            Clear(BotInvBasic);
                            if BotInvBasic.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                BotInvBasic.GetResult(DispatchResult);
                                LogActivity(BotInstance, DispatchResult);
                            end else
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                        end;
                    BotInstance."Bot Type"::"Inventory-Advanced":
                        begin
                            Clear(BotInvAdv);
                            if BotInvAdv.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                BotInvAdv.GetResult(DispatchResult);
                                LogActivity(BotInstance, DispatchResult);
                            end else
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                        end;
                    BotInstance."Bot Type"::Assembly:
                        begin
                            Clear(BotAssem);
                            if BotAssem.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                BotAssem.GetResult(DispatchResult);
                                LogActivity(BotInstance, DispatchResult);
                            end else
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                        end;
                    BotInstance."Bot Type"::Manufacturing:
                        begin
                            Clear(BotManuf);
                            if BotManuf.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                BotManuf.GetResult(DispatchResult);
                                LogActivity(BotInstance, DispatchResult);
                            end else
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                        end;
                    BotInstance."Bot Type"::Research:
                        begin
                            Clear(BotResearch);
                            if BotResearch.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                BotResearch.GetResult(DispatchResult);
                                LogActivity(BotInstance, DispatchResult);
                            end else
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                        end;
                    BotInstance."Bot Type"::Marketing:
                        begin
                            Clear(BotMarketing);
                            if BotMarketing.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                BotMarketing.GetResult(DispatchResult);
                                LogActivity(BotInstance, DispatchResult);
                            end else
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                        end;

                end;
                Commit();
            until BotInstance.Next() = 0;
    end;


    local procedure LogActivity(var BotInstance: Record "BCS Bot Instance"; var DispatchResult: Record "BCS Dispatch Result" temporary)
    var
        BotActLog: Record "BCS Bot Activity Log";
    begin
        Clear(BotActLog);
        BotActLog.Init();
        BotActLog."Bot Type" := BotInstance."Bot Type";
        BotActLog."Bot Instance" := BotInstance."Instance ID";
        BotActLog."Posting Date" := WorkDate();
        BotActLog.Description := DispatchResult.ResultText;
        BotActLog."Activity Type" := DispatchResult."Action Type";
        BotActLog.Insert(true);
    end;

    local procedure LogError(var BotInstance: Record "BCS Bot Instance")
    var
        BCSErrorMgmt: Codeunit "BCS Error Management";
    begin
        BCSErrorMgmt.ThrowPlayerBotError(BotInstance, GetLastErrorText());
    end;
}
