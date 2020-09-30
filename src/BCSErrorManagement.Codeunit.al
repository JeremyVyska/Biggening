codeunit 88019 "BCS Error Management"
{
    Permissions = tabledata "BCS Bot Error Log" = im;

    procedure ThrowPlayerBotError(var BotInstance: Record "BCS Bot Instance"; ErrorMessage: Text)
    var
        RunTrigger: Boolean;
    begin
        RunTrigger := true;
        OnThrowPlayerBotError(BotInstance, ErrorMessage, RunTrigger);
    end;


    [BusinessEvent(false)]
    local procedure OnThrowPlayerBotError(var BotInstance: Record "BCS Bot Instance"; var ErrorMessage: Text; var RunTrigger: Boolean)
    begin
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCS Error Management", 'OnThrowPlayerBotError', '', true, true)]
    local procedure ListenForPlayerBotError(var BotInstance: Record "BCS Bot Instance"; var ErrorMessage: Text; var RunTrigger: Boolean)
    var
        BotErrLog: Record "BCS Bot Error Log";
    begin
        if not RunTrigger then
            exit;

        Clear(BotErrLog);
        BotErrLog.Init();
        BotErrLog."Company Name" := CopyStr(CompanyName(), 1, MaxStrLen(BotErrLog."Company Name"));
        BotErrLog."Error Type" := BotErrLog."Error Type"::PlayerError;
        BotErrLog."Bot Type" := BotInstance."Bot Type";
        BotErrLog."Bot Instance" := BotInstance."Instance ID";
        BotErrLog."Posting Date" := WorkDate();
        //BotErrLog.Description := BotPurchase.GetResultText();
        BotErrLog."Error Message" := COPYSTR(GetLastErrorText(), 1, MAXSTRLEN(BotErrLog."Error Message"));
        //TODO: v0.2 Handle the whole error result with BLOB?
        BotErrLog.Insert(true);
    end;
}
