codeunit 88010 "BCS Bot Assembly"
{
    TableNo = "BCS Bot Instance";

    trigger OnRun()
    begin
        ResultText := StrSubstNo('In the future, I would make %1 assembly ops.', Rec."Operations Per Day");
    end;

    procedure GetResultText(): Text[200]
    begin
        exit(ResultText);
    end;

    var
        ResultText: Text[200];
}
