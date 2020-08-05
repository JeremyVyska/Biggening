codeunit 88016 "BCS Game Date Workdate"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::LogInManagement, 'OnAfterCompanyOpen', '', true, true)]
    local procedure GameDateAsWorkdate()
    begin
        UpdateWorkDate();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCS Player Heartbeat Listener", 'OnHeartbeat', '', true, true)]
    local procedure UpdatePlayerWorkdate()
    begin
        UpdateWorkDate();
    end;

    local procedure UpdateWorkDate()
    var
        CompanyInfo: Record "Company Information";
    begin
        if (CompanyInfo.Get() and (CompanyInfo."Current Game Date" <> 0D)) then
            WorkDate(CompanyInfo."Current Game Date");
    end;
}
