codeunit 88007 "BCS Bot Sales"
{
    TableNo = "BCS Bot Instance";

    trigger OnRun()
    var
        SalesHeader: Record "Sales Header";
        Cust: Record Customer;
        i: Integer;
    begin
        // Safety Measure
        if (Rec."Bot Tier" = 0) then begin
            Rec."Bot Tier" := 1;
            Rec.Modify(true);
        end;

        if Rec."Assignment Code" <> '' then begin
            SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
            SalesHeader.SetRange("Sell-to Customer No.", Rec."Assignment Code");
            SalesHeader.SetRange("Posting Date", WorkDate());
            Cust.Get("Assignment Code");
            if Cust."Max Orders Per Day" = 0 then
                Cust."Max Orders Per Day" := 1;
            if SalesHeader.Count >= Cust."Max Orders Per Day" then begin
                ResultText := StrSubstNo(MaxOrdersPerDayReachedMsg, Rec."Assignment Code", Cust."Max Orders Per Day");
                exit;
            end;

            CreateOrders(Rec)

        end else begin
            ResultText := ('I am missing an Assignment Code and did nothing today.')
        end;

    end;

    procedure GetResultText(): Text[200]
    begin
        exit(ResultText);
    end;




    local procedure CreateOrders(var BotInstance: Record "BCS Bot Instance")
    var
        SalesHeader: Record "Sales Header";
        CustInterests: Record "BCS Customer Interest";
        Item: Record Item;
        TempItems: Record Item temporary;
        MarketCalc: Codeunit "BCS Market Calculation";
        CurrMarketPrice: Decimal;
    begin
        // Determine WHAT the cust will buy, and if any items in stock are over the min. sell price
        CustInterests.SetRange("Customer No.", BotInstance."Assignment Code");
        if CustInterests.FindSet(false) then
            repeat
                Item.SetRange("Gen. Prod. Posting Group", CustInterests."Prod. Posting Group");
                Item.SetRange("Item Category Code", CustInterests."Item Category Code");
                if (not Item.IsEmpty) then begin
                    Item.CalcFields(Inventory, "Qty. on Sales Order");
                    if (Item.Inventory - Item."Qty. on Sales Order" > 0) then begin
                        CurrMarketPrice := MarketCalc.GetMarketPrice(Item."No.");
                        if Item."BCS Min. Sales Price." <= CurrMarketPrice then begin
                            TempItems."No." := Item."No.";
                            TempItems."BCS Min. Sales Price." := CurrMarketPrice - Item."BCS Min. Sales Price.";
                            TempItems."BCS Maximum Stock" := Item.Inventory - Item."Qty. on Sales Order";
                            if not TempItems.IsTemporary then
                                error('TempItems is not temporary!');
                            TempItems.Insert(false);
                        end;
                    end;
                end;
            until CustInterests.Next() = 0;
        if TempItems.IsEmpty then begin
            ResultText := NoStockOverMarketPriceMsg;
            exit;
        end;

        SalesHeader.Validate("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.Validate("Sell-To Customer No.", BotInstance."Assignment Code");
        SalesHeader.Insert(true);

        CreateLines(BotInstance, SalesHeader, TempItems);
    end;


    local procedure CreateLines(var BotInstance: Record "BCS Bot Instance"; var SalesHeader: Record "Sales Header"; var TempInterestedItems: Record Item temporary)
    var
        SalesLine: Record "Sales Line";
        MarketCalc: Codeunit "BCS Market Calculation";
        NextLineNo: Integer;
        i: Integer;
    begin
        NextLineNo := 10000;
        if BotInstance."Maximum Doc. Lines Per Op" = 0 then
            BotInstance."Maximum Doc. Lines Per Op" := 1;

        // Find the highest value trade
        TempInterestedItems.SetCurrentKey("BCS Min. Sales Price.");
        TempInterestedItems.SetAscending("BCS Min. Sales Price.", false);
        if TempInterestedItems.FindFirst() then;

        for i := 1 to BotInstance."Maximum Doc. Lines Per Op" do begin
            SalesLine.Validate("Document Type", SalesHeader."Document Type");
            SalesLine.Validate("Document No.", SalesHeader."No.");
            SalesLine.Validate("Line No.", NextLineNo);
            NextLineNo := NextLineNo + 10000;
            SalesLine.Insert(true);
            SalesLine.Validate(Type, SalesLine.Type::Item);
            SalesLine.Validate("No.", TempInterestedItems."No.");

            // Qty to Sell:  Max of Inventory.  Use Ops/d
            if (BotInstance.GetOpsPerDay() > TempInterestedItems."BCS Maximum Stock") then
                SalesLine.Validate(Quantity, TempInterestedItems."BCS Maximum Stock")
            else
                SalesLine.Validate(Quantity, BotInstance.GetOpsPerDay());


            SalesLine.validate("Unit Price", MarketCalc.GetMarketPrice(SalesLine."No."));
            SalesLine.Modify(true);

            TempInterestedItems."BCS Maximum Stock" := TempInterestedItems."BCS Maximum Stock" - SalesLine.Quantity;
            TempInterestedItems.Modify(false);
            if TempInterestedItems."BCS Maximum Stock" <= 0 then
                if TempInterestedItems.Next() = 0 then
                    exit;
        end;
    end;


    var
        ResultText: Text[200];
        MaxOrdersPerDayReachedMsg: Label 'Customer No. %1 already has %2 orders for that date.';
        NoStockOverMarketPriceMsg: Label 'There are no Items in stock over market price.';
}
