codeunit 88001 "BCS Bot Management"
{

    procedure PurchaseBot(WhichTemplate: Code[20]): Text[20]
    var
        Template: Record "BCS Bot Template";
        Instance: Record "BCS Bot Instance";
    begin
        Template.Get(WhichTemplate);

        Instance.Init();
        Instance."Bot Type" := Template."Bot Type";
        Instance."Power Per Day" := Template."Base Power Per Day";
        Instance."Operations Per Day" := Template."Base Operations Per Day";
        Instance.Price := Template."Base Price";
        Instance.Validate(Designation, GenerateDesignator());
        Instance.Insert(true);

        exit(Instance.Designation);
    end;

    local procedure GenerateDesignator(): Text[10]
    var
        NewDesig: TextBuilder;
        Letter: Text[1];
    begin
        //A = 65 Z = 90
        Letter[1] := Random(26) + 64;
        NewDesig.Append(Letter);
        Letter[1] := Random(26) + 64;
        NewDesig.Append(Letter);
        NewDesig.Append('-');
        NewDesig.Append(Format(Random(9)) + Format(Random(9)) + Format(Random(9)));

        exit(NewDesig.ToText())
    end;
}