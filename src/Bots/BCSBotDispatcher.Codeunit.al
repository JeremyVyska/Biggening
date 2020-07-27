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

        BotInstance.SetRange("Bot Type", BotInstance."Bot Type"::Research);
        HandleBotsOfType(BotInstance);

        BotInstance.SetRange("Bot Type", BotInstance."Bot Type"::Marketing);
        HandleBotsOfType(BotInstance);

    end;

    local procedure HandleBotsOfType(var BotInstance: Record "BCS Bot Instance")
    var
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
                                LogActivity(BotInstance, BotSales.GetResultText());
                            end else begin
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                            end;
                        end;

                    BotInstance."Bot Type"::Purchasing:
                        begin
                            Clear(BotPurchase);
                            if BotPurchase.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                LogActivity(BotInstance, BotPurchase.GetResultText());
                            end else begin
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                            end;
                        end;
                    BotInstance."Bot Type"::"Inventory-Basic":
                        begin
                            Clear(BotInvBasic);
                            if BotInvBasic.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                LogActivity(BotInstance, BotInvBasic.GetResultText());
                            end else begin
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                            end;
                        end;
                    BotInstance."Bot Type"::"Inventory-Advanced":
                        begin
                            Clear(BotInvAdv);
                            if BotInvAdv.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                LogActivity(BotInstance, BotInvAdv.GetResultText());
                            end else begin
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                            end;
                        end;
                    BotInstance."Bot Type"::Assembly:
                        begin
                            Clear(BotAssem);
                            if BotAssem.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                LogActivity(BotInstance, BotAssem.GetResultText());
                            end else begin
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                            end;
                        end;
                    BotInstance."Bot Type"::Manufacturing:
                        begin
                            Clear(BotManuf);
                            if BotManuf.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                LogActivity(BotInstance, BotManuf.GetResultText());
                            end else begin
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                            end;
                        end;
                    BotInstance."Bot Type"::Research:
                        begin
                            Clear(BotResearch);
                            if BotResearch.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                LogActivity(BotInstance, BotResearch.GetResultText());
                            end else begin
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                            end;
                        end;
                    BotInstance."Bot Type"::Marketing:
                        begin
                            Clear(BotMarketing);
                            if BotMarketing.Run(BotInstance) then begin
                                // YAY! It worked - log to the player activity log
                                LogActivity(BotInstance, BotMarketing.GetResultText());
                            end else begin
                                // It hit an error -  log to the system error log
                                LogError(BotInstance);
                            end;
                        end;

                end;
                Commit();
            until BotInstance.Next() = 0;
    end;


    local procedure LogActivity(var BotInstance: Record "BCS Bot Instance"; result: Text[200])
    var
        BotActLog: Record "BCS Bot Activity Log";
    begin
        Clear(BotActLog);
        BotActLog.Init();
        BotActLog."Bot Type" := BotInstance."Bot Type";
        BotActLog."Bot Instance" := BotInstance."Instance ID";
        BotActLog."Posting Date" := WorkDate();
        BotActLog.Description := result;
        BotActLog.Insert(true);
    end;

    local procedure LogError(var BotInstance: Record "BCS Bot Instance")
    var
        BotErrLog: Record "BCS Bot Error Log";
    begin
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
}
