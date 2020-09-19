codeunit 88003 "BCS Player Heartbeat Listener"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        CompanyInformation: Record "Company Information";
        GameSetup: Record "BCS Game Setup";
        MissedDays: Integer;
        i: Integer;
    begin
        CompanyInformation.Get();
        GameSetup.Get();
        if CompanyInformation."Current Game Date" <> GameSetup."Game Date" then begin
            MissedDays := GameSetup."Game Date" - CompanyInformation."Current Game Date";
            for i := 1 to MissedDays do begin
                CompanyInformation."Current Game Date" := CalcDate('<+1D>', CompanyInformation."Current Game Date");
                CompanyInformation.Modify(true);
                OnHeartbeat();
                //NOTE: I'm not 100% how this will play for performance.
            end;
        end;

        CleanOldJobQueueEntries(Rec);
    end;

    procedure CleanOldJobQueueEntries(WhichJob: Record "Job Queue Entry")
    var
        JobQueueLog: Record "Job Queue Log Entry";
    begin
        JobQueueLog.SetRange("ID", WhichJob.ID);
        JobQueueLog.DeleteEntries(3);  // 3 calendar days seems plenty
    end;

    [BusinessEvent(false)]
    local procedure OnHeartbeat()
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Queue Log Entry", 'OnBeforeDeleteEntries', '', true, true)]
    local procedure MyProcedure(var JobQueueLogEntry: Record "Job Queue Log Entry"; var SkipConfirm: Boolean)
    begin
        // This whole event as a safety check to prevent Confirmation message to user about what's up.
        SkipConfirm := true;
    end;
}