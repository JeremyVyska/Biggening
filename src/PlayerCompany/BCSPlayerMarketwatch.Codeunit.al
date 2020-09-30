codeunit 88022 "BCS Player Marketwatch"
{

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Quantity', true, true)]
    local procedure SalesLineValidateQuantity
    (
        var Rec: Record "Sales Line"
    )
    var
        BCSMarketTrades: Record "BCS Market Trades";
    begin
        if not BCSMarketTrades.Get(Rec."No.", CompanyName(), WorkDate()) then begin
            BCSMarketTrades."Item No." := Rec."No.";
            BCSMarketTrades.Company := CopyStr(CompanyName(), 1, MaxStrLen(BCSMarketTrades.Company));
            BCSMarketTrades.Date := WorkDate();
            BCSMarketTrades."Total Trades" := Rec.Quantity;
            BCSMarketTrades.Insert(true);
        end else begin
            BCSMarketTrades."Total Trades" := BCSMarketTrades."Total Trades" + Rec.Quantity;
            BCSMarketTrades.Modify(true);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Quantity', true, true)]
    local procedure PurchaseLineValidateQuantity
        (
            var Rec: Record "Purchase Line"
        )
    var
        BCSMarketTrades: Record "BCS Market Trades";
    begin
        if not BCSMarketTrades.Get(Rec."No.", CompanyName(), WorkDate()) then begin
            BCSMarketTrades."Item No." := Rec."No.";
            BCSMarketTrades.Company := CopyStr(CompanyName(), 1, MaxStrLen(BCSMarketTrades.Company));
            BCSMarketTrades.Date := WorkDate();
            BCSMarketTrades."Total Trades" := Rec.Quantity;
            BCSMarketTrades.Insert(true);
        end else begin
            BCSMarketTrades."Total Trades" := BCSMarketTrades."Total Trades" + Rec.Quantity;
            BCSMarketTrades.Modify(true);
        end;
    end;
}
