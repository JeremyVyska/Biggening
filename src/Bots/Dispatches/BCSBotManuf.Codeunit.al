codeunit 88011 "BCS Bot Manuf."
{
    TableNo = "BCS Bot Instance";

    trigger OnRun()
    begin
        ResultText := StrSubstNo('In the future, I would make %1 manuf. ops.', Rec."Operations Per Day");
    end;

    procedure GetResult(var DispatchResult: Record "BCS Dispatch Result" temporary)
    begin
        Clear(DispatchResult);
        DispatchResult.ResultText := ResultText;
    end;

    var
        ResultText: Text[200];
}
