codeunit 88012 "BCS Bot Research"
{
    TableNo = "BCS Bot Instance";

    trigger OnRun()
    begin
        //ResultText := StrSubstNo('In the future, I would make %1 research ops.', Rec."Operations Per Day");
        // Once per day, ops per instance, research points per op
        // Locate the selected search and validate/add the points
        ApplyResearch(Rec);
    end;

    local procedure ApplyResearch(var Rec: Record "BCS Bot Instance")
    var
        BCSPlayerResearch: Record "BCS Research Progress";
        PointsToAdd: Decimal;
    begin
        PointsToAdd := Rec.GetOpsPerDay() * Rec.GetResearchPerOp();
        SetResult(StrSubstNo('I''ve generated %1 points.', PointsToAdd), MyResult."Action Type"::Activity);
        BCSPlayerResearch.SetRange(Selected, true);
        if BCSPlayerResearch.FindFirst() then begin
            BCSPlayerResearch.Validate(Progress, BCSPlayerResearch.Progress + PointsToAdd);
            BCSPlayerResearch.Modify(true);
        end;
    end;

    procedure GetResult(var DispatchResult: Record "BCS Dispatch Result" temporary)
    begin
        Clear(DispatchResult);
        DispatchResult.TransferFields(MyResult);
    end;

    procedure SetResult(newText: Text[200]; whichType: Enum "BCS Bot Result Type")
    begin
        MyResult."Action Type" := whichType;
        MyResult.ResultText := newText;
    end;


    var
        MyResult: Record "BCS Dispatch Result" temporary;
}
