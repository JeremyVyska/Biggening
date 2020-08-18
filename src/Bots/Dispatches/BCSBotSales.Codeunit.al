codeunit 88007 "BCS Bot Sales"
{
    TableNo = "BCS Bot Instance";

    trigger OnRun()
    var
        i: Integer;
    begin
        // Safety Measure
        if (Rec."Bot Tier" = 0) then begin
            Rec."Bot Tier" := 1;
            Rec.Modify(true);
        end;

        for i := 1 to Rec.GetOpsPerDay() do begin
            if Rec."Assignment Code" <> '' then begin
                CreateSO(Rec."Assignment Code");
            end;
        end;

        if Rec."Assignment Code" = '' then
            ResultText := ('I am missing an Assignment Code and did nothing today.')
        else
            ResultText := StrSubstNo('I created %1 sales orders.', Rec."Operations Per Day");
        //ResultText := StrSubstNo('In the future, I would make %1 sales.', Rec."Operations Per Day");
    end;

    procedure GetResultText(): Text[200]
    begin
        exit(ResultText);
    end;




    local procedure CreateSO(CustomerNo: Code[20]): Code[20]
    var
        SalesHeader: Record "Sales Header";
    begin
        // Count of BOTH The open SO docs, and the posted docs

        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.Validate("Sell-To Customer No.", CustomerNo);
        SalesHeader.Insert(true);

        //Testing, just one
        CreateLine(SalesHeader);

        exit(SalesHeader."No.");
    end;


    local procedure CreateLine(var SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        NextLineNo: Integer;
    begin
        //Later, NextLineNo ?
        NextLineNo := 10000;

        SalesLine.Validate("Document Type", SalesHeader."Document Type");
        SalesLine.Validate("Document No.", SalesHeader."No.");
        SalesLine.Validate("Line No.", NextLineNo);
        SalesLine.Insert(true);
        SalesLine.Validate(Type, SalesLine.Type::Item);
        SalesLine.Validate("No.", '1000');
        SalesLine.Validate(Quantity, Random(10) + 10);
        SalesLine.validate("Unit Price", Random(20) + 10);
        SalesLine.Modify(true);
    end;


    var
        ResultText: Text[200];
}
