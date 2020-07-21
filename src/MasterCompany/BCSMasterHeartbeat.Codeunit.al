codeunit 88002 "BCS Master Heartbeat"
{
    trigger OnRun()
    var
        GameSetup: Record "BCS Game Setup";
    begin
        GameSetup.Get();
        GameSetup."Game Date" := CalcDate('<+1D>', GameSetup."Game Date");
        GameSetup.Modify(true);
    end;
}