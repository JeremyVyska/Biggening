codeunit 88018 "BCS Location Management"
{

    procedure PurchaseLocation(Basic: Boolean)
    var
        GLAccount: Record "G/L Account";
        GameSetup: Record "BCS Game Setup";
        Location: Record Location;
        InvtPostingSetup: Record "Inventory Posting Setup";
        LocationCard: Page "Location Card";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        AmountToCharge: Decimal;
        InsufficientFundsErr: Label 'You do not have enough cash to complete this purchase.';
    begin
        GameSetup.Get();
        GameSetup.TestField("Location No. Series");
        GameSetup.TestField("Inventory Account");

        GLAccount.Get(GameSetup."Cash Account");
        GLAccount.CalcFields(Balance);
        if Basic then
            AmountToCharge := GameSetup."Basic Location Price"
        else
            AmountToCharge := GameSetup."Adv. Location Price";

        if (GLAccount.Balance < AmountToCharge) then
            Error(InsufficientFundsErr);

        Location.Code := NoSeriesMgmt.GetNextNo(GameSetup."Location No. Series", WorkDate(), true);
        if (Basic) then begin
            Location.Name := 'Basic ' + Location.Code;
            Location."Maximum Bots" := GameSetup."Basic Loc. Max. Bots";
            Location."Maximum Units" := GameSetup."Basic Loc. Max. Units";

        end else begin
            //TODO: v0.v2+ Advanced Location
        end;
        Location.Insert(true);
        InvtPostingSetup."Location Code" := Location.code;
        InvtPostingSetup."Invt. Posting Group Code" := GameSetup."Inventory Posting Group";
        InvtPostingSetup."Inventory Account" := GameSetup."Inventory Account";
        InvtPostingSetup.Insert(true);

        //Charge the player
        ChargeThePlayer(AmountToCharge, Location, GameSetup);

        LocationCard.SetRecord(Location);
        LocationCard.Run();
    end;

    local procedure ChargeThePlayer(AmountToCharge: Decimal; Location: Record Location; GameSetup: Record "BCS Game Setup")
    var
        PlayerCharge: Codeunit "BCS Player Charge";
        LocationChargeTok: Label 'Purchase of Location';
    begin
        GameSetup.Get();
        PlayerCharge.ChargeCash(GameSetup."FA Value Account Location", AmountToCharge, Location.Code, LocationChargeTok);
    end;



    /*
 
 8888888888 888     888 8888888888 888b    888 88888888888 .d8888b.  
 888        888     888 888        8888b   888     888    d88P  Y88b 
 888        888     888 888        88888b  888     888    Y88b.      
 8888888    Y88b   d88P 8888888    888Y88b 888     888     "Y888b.   
 888         Y88b d88P  888        888 Y88b888     888        "Y88b. 
 888          Y88o88P   888        888  Y88888     888          "888 
 888           Y888P    888        888   Y8888     888    Y88b  d88P 
 8888888888     Y8P     8888888888 888    Y888     888     "Y8888P"  
                                                                     
                                                                     
                                                                     
 
*/

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
        if not PurchHeader.Receive then
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
