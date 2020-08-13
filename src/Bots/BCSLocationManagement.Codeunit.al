codeunit 88018 "BCS Location Management"
{

    procedure PurchaseLocation(Basic: Boolean)
    var
        GameSetup: Record "BCS Game Setup";
        Location: Record Location;
        InvtPostingSetup: Record "Inventory Posting Setup";
        LocationCard: Page "Location Card";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
    begin
        GameSetup.Get();
        GameSetup.TestField("Location No. Series");
        Location.Code := NoSeriesMgmt.GetNextNo(GameSetup."Location No. Series", WorkDate(), true);
        if (Basic) then begin
            Location.Name := 'Basic ' + Location.Code;
            Location."Maximum Bots" := GameSetup."Basic Loc. Max. Bots";
            Location."Maximum Units" := GameSetup."Basic Loc. Max. Units";

        end else begin
            //TODO: Advanced Location
        end;
        Location.Insert(true);
        //TODO: Inventory Setup : Setup driven
        InvtPostingSetup."Location Code" := Location.code;
        InvtPostingSetup."Invt. Posting Group Code" := 'ITEM';
        InvtPostingSetup."Inventory Account" := '1420';
        InvtPostingSetup.Insert(true);

        LocationCard.SetRecord(Location);
        LocationCard.Run();
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
        if Location.Get(PurchLine."Location Code") and (Location."Maximum Units" <> 0) then begin
            Location.CalcFields("Total Stock");
            if (Location."Total Stock" + PurchLine."Qty. to Receive" > Location."Maximum Units") then
                Error(LocationOvercapacityErr, Location.Code, Location."Maximum Units", PurchLine."Qty. to Receive", Location."Total Stock");
        end;
    end;

    var
        LocationOvercapacityErr: Label 'Location %1 has a Capacity of %2 and cannot accept %3 units because of the %4 already in stock.';

}
