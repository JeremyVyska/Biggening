codeunit 88001 "BCS Bot Management"
{

    procedure PurchaseBot(var ResCheckBuffer: Record "BCS Resource Check Buffer"; WhichTemplate: Code[20]): Text[20]
    var
        Template: Record "BCS Bot Template";
        Instance: Record "BCS Bot Instance";
        BCSPlayerCharge: Codeunit "BCS Player Charge";
        BotDesignation: Code[20];
    begin
        Template.Get(WhichTemplate);
        BotDesignation := GenerateDesignator();

        // Charge the Materials to the Player
        if ResCheckBuffer.FindSet() then
            repeat
                if (ResCheckBuffer."Item No." = '') then
                    BCSPlayerCharge.ChargeCash('1410', ResCheckBuffer.Requirement, BotDesignation)
                else
                    BCSPlayerCharge.ChargeMaterial(ResCheckBuffer."Item No.", ResCheckBuffer.Requirement, BotDesignation);
            until ResCheckBuffer.Next() = 0;

        // Create the Bot Instance
        Instance.Init();
        Instance."Bot Type" := Template."Bot Type";
        Instance."Bot Tier" := Template."Bot Tier";
        Instance."Power Per Day" := Template."Base Power Per Day";
        Instance."Operations Per Day" := Template."Base Operations Per Day";
        Instance.Price := Template."Base Price";
        Instance.Validate(Designation, BotDesignation);

        case Template."Bot Type" of
            Template."Bot Type"::Research:
                begin
                    Instance."Research Points Per Op" := Template."Research Points Per Op";
                end;
        end;
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

    procedure GenerateReqBuffer(var ResCheckBuffer: Record "BCS Resource Check Buffer"; WhichTemplate: Record "BCS Bot Template")
    var
        GLAccount: Record "G/L Account";
        Item: Record Item;
        GameSetup: Record "BCS Game Setup";
        TemplateReq: Record "BCS Bot Template Req.";
        MasterItem: Record "BCS Master Item";
        NextLineNo: Integer;
    begin
        GameSetup.Get();

        // Always do Cash first
        ResCheckBuffer."Line No." := 1;
        ResCheckBuffer.Description := StrSubstNo(CashTok);
        //TODO: Event safe Price
        ResCheckBuffer.Requirement := WhichTemplate."Base Price";
        GLAccount.Get(GameSetup."Cash Account");
        GLAccount.CalcFields(Balance);
        ResCheckBuffer.Inventory := GLAccount.Balance;
        ResCheckBuffer.Shortage := ResCheckBuffer.Inventory < ResCheckBuffer.Requirement;
        if (ResCheckBuffer.Shortage) then
            ResCheckBuffer.LineStyle := 'attention'
        else
            ResCheckBuffer.LineStyle := 'standard';
        ResCheckBuffer.Insert();
        NextLineNo := 2;

        //for each Temp. Req., create an entry, calc on-hand
        TemplateReq.SetRange("Bot Template Code", WhichTemplate.Code);
        if TemplateReq.FindSet() then
            repeat
                ResCheckBuffer."Line No." := NextLineNo;
                NextLineNo := NextLineNo + 1;
                MasterItem.Get(TemplateReq."Master Item No.");
                ResCheckBuffer."Item No." := MasterItem."No.";
                ResCheckBuffer.Description := MasterItem.Description;
                ResCheckBuffer.Requirement := TemplateReq.Quantity;
                if (Item.Get(TemplateReq."Master Item No.")) then begin
                    Item.CalcFields(Inventory);
                    ResCheckBuffer.Inventory := Item.Inventory;
                end else
                    ResCheckBuffer.Inventory := 0;
                ResCheckBuffer.Shortage := ResCheckBuffer.Inventory < ResCheckBuffer.Requirement;
                if (ResCheckBuffer.Shortage) then
                    ResCheckBuffer.LineStyle := 'attention'
                else
                    ResCheckBuffer.LineStyle := 'standard';
                ResCheckBuffer.Insert();
            until TemplateReq.Next() = 0;
    end;

    var
        CashTok: Label 'Money';
}