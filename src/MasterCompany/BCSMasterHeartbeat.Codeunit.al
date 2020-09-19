codeunit 88002 "BCS Master Heartbeat"
{
    TableNo = "Job Queue Entry";

    trigger OnRun()
    var
        GameSetup: Record "BCS Game Setup";
    begin
        GameSetup.Get();
        GameSetup."Game Date" := CalcDate('<+1D>', GameSetup."Game Date");
        GameSetup.Modify(true);
        CleanOldJobQueueEntries(Rec);
        OnMasterHeartbeat();
    end;


    procedure CleanOldJobQueueEntries(WhichJob: Record "Job Queue Entry")
    var
        JobQueueLog: Record "Job Queue Log Entry";
    begin
        JobQueueLog.SetRange("ID", WhichJob.ID);
        JobQueueLog.DeleteEntries(3);  // 3 calendar days seems plenty
    end;

    [BusinessEvent(false)]
    local procedure OnMasterHeartbeat()
    begin
    end;

    [EventSubscriber(ObjectType::Table, Database::"Job Queue Log Entry", 'OnBeforeDeleteEntries', '', true, true)]
    local procedure MyProcedure(var JobQueueLogEntry: Record "Job Queue Log Entry"; var SkipConfirm: Boolean)
    begin
        // This whole event as a safety check to prevent Confirmation message to user about what's up.
        SkipConfirm := true;
    end;
}