codeunit 88029 "BCS Bot Error Log Cleaner"
{
    local procedure CleanBotErrorLogs(Days: Integer)
    var
        BotErrorLog: Record "BCS Bot Error Log";
    begin
        BotErrorLog.DeleteOldEntries(Days);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCS Master Heartbeat", 'OnMasterHeartbeat', '', true, true)]
    local procedure "BCS Master Heartbeat_OnMasterHeartbeat"()
    begin
        CleanBotErrorLogs(7);
    end;
}
