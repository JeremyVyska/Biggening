codeunit 88006 "BCS Bot Purchase"
{
    TableNo = "BCS Bot Instance";

    trigger OnRun()
    begin
        //Error('Hello Stream!');
        ResultText := StrSubstNo('In the future, I would make %1 purchases.', Rec."Operations Per Day");
    end;

    procedure GetResultText(): Text[200]
    begin
        exit(ResultText);
    end;

    var
        ResultText: Text[200];
}
