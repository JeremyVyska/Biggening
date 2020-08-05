codeunit 88003 "BCS Player Heartbeat Listener"
{
    //TODO: Clean up Job Queue Entries

    trigger OnRun()
    var
        CompanyInformation: Record "Company Information";
        GameSetup: Record "BCS Game Setup";
    begin
        CompanyInformation.Get();
        GameSetup.Get();
        if CompanyInformation."Current Game Date" <> GameSetup."Game Date" then begin
            //TODO: Date math for fault tolerance
            CompanyInformation."Current Game Date" := GameSetup."Game Date";
            CompanyInformation.Modify(true);

            OnHeartbeat();
        end;
    end;

    [BusinessEvent(false)]
    local procedure OnHeartbeat()
    begin
    end;
}