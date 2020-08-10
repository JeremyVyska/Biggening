codeunit 88018 "BCS Location Checks"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterTestPurchLine', '', true, true)]
    local procedure "Purch.-Post_OnAfterTestPurchLine"
    (
        PurchHeader: Record "Purchase Header";
        PurchLine: Record "Purchase Line";
        WhseReceive: Boolean;
        WhseShip: Boolean
    )
    var
        Location: Record Location;
    begin
        if PurchLine."Location Code" = '' then
            exit;
        if Location.Get(PurchLine."Location Code") and (Location."Maximum Units" <> 0) then begin
            Location.CalcFields("Total Stock");
            if (Location."Total Stock" + PurchLine."Qty. to Receive" > Location."Maximum Units") then
                Error(LocationOvercapacityErr, Location.Code, Location."Maximum Units", PurchLine."Qty. to Receive", Location."Total Stock");
        end;
    end;

    var
        LocationOvercapacityErr: Label 'Location %1 has a Capacity of %2 and cannot accept %3 units because of the %4 already in stock.';

}
