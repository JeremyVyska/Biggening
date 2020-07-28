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
        PointsToAdd := Rec."Operations Per Day" * Rec."Research Points Per Op";
        ResultText := StrSubstNo('I''ve generated %1 points.', PointsToAdd);
        BCSPlayerResearch.SetRange(Selected, true);
        if BCSPlayerResearch.FindFirst() then begin
            BCSPlayerResearch.Validate(Progress, BCSPlayerResearch.Progress + PointsToAdd);
            BCSPlayerResearch.Modify(true);
        end;
    end;

    procedure GetResultText(): Text[200]
    begin
        exit(ResultText);
    end;

    var
        ResultText: Text[200];
}
