codeunit 88028 "BCS Research Event Master"
{

    local procedure AlreadyResearched(ResearchNo: Integer): Boolean
    var
        ResProgress: Record "BCS Research Progress";
    begin
        ResProgress.SetRange("No.", ResearchNo);
        ResProgress.SetRange(Completed, true);
        exit(not ResProgress.IsEmpty());
    end;

    local procedure ReadyToUnlock(ResearchSetup: Record "BCS Research"): Boolean
    var
        ResPreq: Record "BCS Research Prereq.";
    begin
        // check all Prereq conditions
        ResPreq.SetRange("Research No.", ResearchSetup."No.");
        ResPreq.SetRange("Requirement Type", ResPreq."Requirement Type"::Research);
        if ResPreq.FindSet() then
            repeat
                if not AlreadyResearched(ResPreq.Prerequisite) then
                    exit(false);
            until ResPreq.Next() = 0;

        //TODO: v0.2 Research Materials Prereq

        exit(true);
    end;

    local procedure UnlockResearch(ResearchSetup: Record "BCS Research")
    var
        ResProgress: Record "BCS Research Progress";
    begin
        ResProgress.TransferFields(ResearchSetup);
        ResProgress.Insert(true);
    end;


    [EventSubscriber(ObjectType::Table, Database::"BCS Research Progress", 'OnAfterResearchProgressComplete', '', true, true)]
    local procedure DoAfterResearchProgressComplete(Rec: Record "BCS Research Progress")
    var
        ResearchSetup: Record "BCS Research";
    begin
        ResearchSetup.SetRange("Research Req. Filter", Rec."No.");
        ResearchSetup.SetRange("Has Research Req.", true);
        if ResearchSetup.FindSet() then
            repeat
                if not AlreadyResearched(ResearchSetup."No.") then
                    if ReadyToUnlock(ResearchSetup) then
                        UnlockResearch(ResearchSetup);
            until ResearchSetup.Next() = 0;

    end;

    [EventSubscriber(ObjectType::Table, Database::"BCS Bot Instance", 'OnBeforeGetOpsPerDay', '', true, true)]
    local procedure AdjustOpsPerDay(Rec: Record "BCS Bot Instance"; var CalculatedOpsPerDay: Decimal)
    var
        ResProgress: Record "BCS Research Progress";
    begin
        ResProgress.SetRange(Completed, true);
        ResProgress.SetRange("Operation Bonus Type", ResProgress."Operation Bonus Type"::"Bot Templates");
        ResProgress.SetRange("Operation Bonus Code", Rec."Bot Template Code");
        if ResProgress.FindSet() then
            repeat
                CalculatedOpsPerDay := CalculatedOpsPerDay + ResProgress."Operations Per Day Bonus";
            until ResProgress.Next() = 0;
    end;

    [EventSubscriber(ObjectType::Table, Database::"BCS Bot Instance", 'OnBeforeGetPowerPerDay', '', true, true)]
    local procedure AdjustPowerPerDay(Rec: Record "BCS Bot Instance"; var CalculatedPowerPerDay: Decimal)
    var
        ResProgress: Record "BCS Research Progress";
    begin
        ResProgress.SetRange(Completed, true);
        ResProgress.SetRange("Power Bonus Type", ResProgress."Power Bonus Type"::"Bot Templates");
        ResProgress.SetRange("Power Bonus Code", Rec."Bot Template Code");
        if ResProgress.FindSet() then
            repeat
                CalculatedPowerPerDay := CalculatedPowerPerDay - ResProgress."Power Per Day Bonus";
            until ResProgress.Next() = 0;
        if CalculatedPowerPerDay < 0 then
            CalculatedPowerPerDay := 0;
    end;

}
