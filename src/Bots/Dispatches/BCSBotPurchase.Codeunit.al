codeunit 88006 "BCS Bot Purchase"
{
    TableNo = "BCS Bot Instance";

    trigger OnRun()
    var
        Vendor: Record Vendor;
        PurchHeader: Record "Purchase Header";
        DocNo: Text;
        GeneratedProspects: Integer;
    begin
        // Safety Measure
        if (Rec."Bot Tier" = 0) then begin
            Rec."Bot Tier" := 1;
            Rec.Modify(true);
        end;

        // If the Purchasing Bot is assigned:
        if Rec."Assignment Code" <> '' then begin
            PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
            PurchHeader.SetRange("Buy-from Vendor No.", Rec."Assignment Code");
            PurchHeader.SetRange("Posting Date", WorkDate());
            Vendor.Get("Assignment Code");
            if Vendor."Max Orders Per Day" = 0 then
                Vendor."Max Orders Per Day" := 1;
            if PurchHeader.Count >= Vendor."Max Orders Per Day" then begin
                SetResult(StrSubstNo(MaxOrdersPerDayReachedMsg, Rec."Assignment Code", Vendor."Max Orders Per Day"), MyResult."Action Type"::Idle);
                exit;
            end;
            if not AreAnyOrdersNeeded(Rec) then begin
                SetResult(StrSubstNo(NoOrdersNeededMsg, Rec."Assignment Code"), MyResult."Action Type"::Idle);
                exit;
            end else begin
                DocNo := CreatePO(Rec);
                if (DocNo <> '') then
                    SetResult(StrSubstNo(POCreatedMsg, CreatePO(Rec), Rec."Assignment Code"), MyResult."Action Type"::Activity)
                else
                    SetResult('I ran into errors while creating a PO. Check the Bot Error log for details.', MyResult."Action Type"::Error);
            end;
        end else begin
            // Else, they will 'farm' for new suppliers
            GeneratedProspects := GeneratedProspects + FishForProspect(Rec);
            SetResult(StrSubstNo('I fished for new Suppliers and found %1.', GeneratedProspects), MyResult."Action Type"::Activity);
        end;
    end;

    local procedure AreAnyOrdersNeeded(var BotInstance: Record "BCS Bot Instance"): Boolean
    var
        Vend: Record Vendor;
        VendItem: Record "Item Vendor";
        Item: Record Item;
        MarketCalc: Codeunit "BCS Market Calculation";
    begin
        // The bot is assigned to a vendor, get it.
        if BotInstance."Assignment Code" = '' then
            exit(false);
        Vend.Get(BotInstance."Assignment Code");

        //Look at each Item the vendor supplies
        VendItem.SetRange("Vendor No.", Vend."No.");
        if VendItem.IsEmpty then
            exit(false);
        if VendItem.FindSet() then
            repeat
                //Check the balance of stock in that Vendor Location
                Item.Get(VendItem."Item No.");
                Item.SetRange("Location Filter", Vend."Location Code");
                Item.CalcFields(Inventory, "Qty. on Purch. Order");

                //Factor in the Incoming Supply
                if (Item.Inventory + Item."Qty. on Purch. Order" <= Item."BCS Reorder Level") then
                    //Spit out true if we need to reorder
                    if (MarketCalc.GetMarketPrice(Item."No.") <= Item."BCS Max. Purch Price.") then
                        exit(true);
            until VendItem.Next() = 0;
    end;

    local procedure WhatItemIsNeeded(var BotInstance: Record "BCS Bot Instance"): Code[20]
    var
        Vend: Record Vendor;
        VendItem: Record "Item Vendor";
        Item: Record Item;
        MarketCalc: Codeunit "BCS Market Calculation";
    begin
        // The bot is assigned to a vendor, get it.
        if BotInstance."Assignment Code" = '' then
            exit('');
        Vend.Get(BotInstance."Assignment Code");

        //Look at each Item the vendor supplies
        VendItem.SetRange("Vendor No.", Vend."No.");
        if VendItem.IsEmpty then
            exit('');
        if VendItem.FindSet() then
            repeat
                //Check the balance of stock in that Vendor Location
                Item.Get(VendItem."Item No.");
                Item.SetRange("Location Filter", Vend."Location Code");
                Item.CalcFields(Inventory, "Qty. on Purch. Order");

                //Factor in the Incoming Supply
                if (Item.Inventory + Item."Qty. on Purch. Order" <= Item."BCS Reorder Level") then
                    //Spit out true if we need to reorder
                    if (MarketCalc.GetMarketPrice(Item."No.") <= Item."BCS Max. Purch Price.") then
                        exit(Item."No.");
            until VendItem.Next() = 0;
    end;




    /*
 
  .d8888b.                           888                 8888888b.   .d88888b.  
 d88P  Y88b                          888                 888   Y88b d88P" "Y88b 
 888    888                          888                 888    888 888     888 
 888        888d888 .d88b.   8888b.  888888 .d88b.       888   d88P 888     888 
 888        888P"  d8P  Y8b     "88b 888   d8P  Y8b      8888888P"  888     888 
 888    888 888    88888888 .d888888 888   88888888      888        888     888 
 Y88b  d88P 888    Y8b.     888  888 Y88b. Y8b.          888        Y88b. .d88P 
  "Y8888P"  888     "Y8888  "Y888888  "Y888 "Y8888       888         "Y88888P"  
 
*/

    local procedure CreatePO(var BotInstance: Record "BCS Bot Instance"): Code[20]
    var
        PurchaseHeader: Record "Purchase Header";
        Vendor: Record Vendor;
        BotInstance2: Record "BCS Bot Instance";
        BotErrorLog: Codeunit "BCS Error Management";
        MissingVendorLocationTok: Label 'Vendor %1 is not assigned to a location, so no orders can be placed.';
        MissingBotsForLocationTok: Label 'Location %1 has no logistics bots assigned, so no stock can move. No orders can be made.';
    begin
        // Count of BOTH The open PO docs, and the posted docs
        // Check Vendor has a Location before allowing.
        Vendor.Get(BotInstance."Assignment Code");
        if Vendor."Location Code" = '' then begin
            BotErrorLog.ThrowPlayerBotError(BotInstance, StrSubstNo(MissingVendorLocationTok, Vendor."No."));
            Exit('');  // we don't want to *throw* an error, as that will roll back things.
        end;
        // Check for Logistics Bots
        BotInstance2.SetRange("Assignment Code", Vendor."Location Code"); //this forces bot type Logistics by name
        if BotInstance2.IsEmpty then begin
            BotErrorLog.ThrowPlayerBotError(BotInstance, StrSubstNo(MissingBotsForLocationTok, Vendor."Location Code"));
            Exit('');  // we don't want to *throw* an error, as that will roll back things.
        end;
        PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseHeader.Validate("Buy-from Vendor No.", BotInstance."Assignment Code");
        PurchaseHeader.Insert(true);

        CreateLines(BotInstance, PurchaseHeader);

        exit(PurchaseHeader."No.");
    end;

    /*
 
  .d8888b.                           888                 888      d8b                   
 d88P  Y88b                          888                 888      Y8P                   
 888    888                          888                 888                            
 888        888d888 .d88b.   8888b.  888888 .d88b.       888      888 88888b.   .d88b.  
 888        888P"  d8P  Y8b     "88b 888   d8P  Y8b      888      888 888 "88b d8P  Y8b 
 888    888 888    88888888 .d888888 888   88888888      888      888 888  888 88888888 
 Y88b  d88P 888    Y8b.     888  888 Y88b. Y8b.          888      888 888  888 Y8b.     
  "Y8888P"  888     "Y8888  "Y888888  "Y888 "Y8888       88888888 888 888  888  "Y8888  
 
*/

    local procedure CreateLines(var BotInstance: Record "BCS Bot Instance"; var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        MarketCalc: Codeunit "BCS Market Calculation";
        NextLineNo: Integer;
        i: Integer;
        QuantityToOrder: Decimal;
        PriceToCharge: Decimal;
    begin
        NextLineNo := 10000;
        if BotInstance."Maximum Doc. Lines Per Op" = 0 then
            BotInstance."Maximum Doc. Lines Per Op" := 1;

        for i := 1 to BotInstance."Maximum Doc. Lines Per Op" do begin
            PurchaseLine.Validate("Document Type", PurchaseHeader."Document Type");
            PurchaseLine.Validate("Document No.", PurchaseHeader."No.");
            PurchaseLine.Validate("Line No.", NextLineNo);
            NextLineNo := NextLineNo + 10000;
            PurchaseLine.Insert(true);
            PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
            PurchaseLine.Validate("No.", WhatItemIsNeeded(BotInstance));

            QuantityToOrder := BotInstance.GetOpsPerDay();
            OnBeforeGeneratePOLineSetQuantity(PurchaseLine, BotInstance, QuantityToOrder);
            PurchaseLine.Validate(Quantity, QuantityToOrder);

            PriceToCharge := MarketCalc.GetMarketPrice(PurchaseLine."No.");
            OnBeforeGeneratePOLineSetPrice(PurchaseLine, BotInstance, PriceToCharge);
            PurchaseLine.Validate("Direct Unit Cost", PriceToCharge);

            PurchaseLine.Modify(true);
            OnAfterGeneratePurchLine(PurchaseLine, BotInstance);
        end;
    end;



    /*

     8888888888 d8b          888      d8b                   
     888        Y8P          888      Y8P                   
     888                     888                            
     8888888    888 .d8888b  88888b.  888 88888b.   .d88b.  
     888        888 88K      888 "88b 888 888 "88b d88P"88b 
     888        888 "Y8888b. 888  888 888 888  888 888  888 
     888        888      X88 888  888 888 888  888 Y88b 888 
     888        888  88888P' 888  888 888 888  888  "Y88888 
                                                        888 
                                                   Y8b d88P 
                                                    "Y88P"  

    */

    local procedure FishForProspect(whichBot: Record "BCS Bot Instance") Generated: Integer
    var
        CompanyInfo: Record "Company Information";
        GameSetup: Record "BCS Game Setup";
        Prospect: Record "BCS Prospect";
        Trades: Record "BCS Prospect Trades";
        MasterItem: Record "BCS Master Item";
        TempMasterItem: Record "BCS Master Item" temporary;
        IfRunTrigger: Boolean;
        i: Integer;
        j: Integer;
    begin
        if not CompanyInfo.Get() then
            Error('');
        if not GameSetup.Get() then
            Error('');
        GameSetup.TestField("Purchase Prospect Effort");
        GameSetup.TestField("Purch. Pros. Base Max Orders");
        GameSetup.TestField("Purch. Pros. Base Max Quantity");
        GameSetup.TestField("Purch. Pros. Tier Multiplier");

        CompanyInfo."Purchase Prospect Effort" := CompanyInfo."Purchase Prospect Effort" + whichBot.GetOpsPerDay();
        CompanyInfo.Modify(false);

        if (CompanyInfo."Purchase Prospect Effort" > GameSetup."Purchase Prospect Effort") then begin
            Prospect.Type := Prospect.Type::Vendor;
            GetRandomName(Prospect);
            Prospect."Maximum Orders Per Day" := Round(GameSetup."Purch. Pros. Base Max Orders" * (whichBot."Bot Tier" * GameSetup."Purch. Pros. Tier Multiplier"));
            Prospect."Maximum Quantity Per Order" := Round(GameSetup."Purch. Pros. Base Max Quantity" * (whichBot."Bot Tier" * GameSetup."Purch. Pros. Tier Multiplier"));
            Prospect.Insert(true);
            Generated := Generated + 1;

            // Trade Creation
            MasterItem.SetRange("Prod. Posting Group", 'CLASS1');  //This OK hardcoding for now
            IfRunTrigger := true;
            OnBeforeProspectTrades(Prospect, MasterItem, IfRunTrigger);
            if IfRunTrigger then begin
                for i := 1 to whichBot."Bot Tier" do begin
                    j := 0;
                    TempMasterItem.Reset();
                    repeat
                        if MasterItem.FindFirst() then
                            MasterItem.Next(Random(MasterItem.Count) - 1);
                        j := j + 1
                    until ((not TempMasterItem.Get(MasterItem."No.")) or (j > 20));
                    if TempMasterItem."No." = '' then begin
                        TempMasterItem := MasterItem;
                        TempMasterItem.Insert(false);

                        Trades.Reset();
                        Trades."Prospect No." := Prospect."No.";
                        Trades."Item No." := MasterItem."No.";
                        Trades.Insert(true);
                    end else
                        Error('');
                end;
            end;
            OnAfterProspectTrades(Prospect, Trades);
        end;
    end;

    local procedure GetRandomName(var Prospect: Record "BCS Prospect")
    var
        RandomNamePool: Record "BCS Random Entity Name Pool";
    begin
        if not RandomNamePool.FindFirst() then
            Error('');
        RandomNamePool.Next(Random(RandomNamePool.Count) - 1);
        Prospect.Name := RandomNamePool."Company Name";
        Prospect."Random Entry Source No." := RandomNamePool."Entry No.";

    end;


    /*

     8888888888                           888             
     888                                  888             
     888                                  888             
     8888888   888  888  .d88b.  88888b.  888888 .d8888b  
     888       888  888 d8P  Y8b 888 "88b 888    88K      
     888       Y88  88P 88888888 888  888 888    "Y8888b. 
     888        Y8bd8P  Y8b.     888  888 Y88b.       X88 
     8888888888  Y88P    "Y8888  888  888  "Y888  88888P' 




    */


    [BusinessEvent(false)]
    local procedure OnBeforeProspectTrades(var Prospect: Record "BCS Prospect"; var MasterItems: Record "BCS Master Item"; var RunTrigger: Boolean)
    begin
    end;

    [BusinessEvent(false)]
    local procedure OnAfterProspectTrades(var Prospect: Record "BCS Prospect"; var Trades: Record "BCS Prospect Trades")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGeneratePurchLine(var PurchaseLine: Record "Purchase Line"; var BotInstance: Record "BCS Bot Instance")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGeneratePOLineSetPrice(var PurchaseLine: Record "Purchase Line"; var BotInstance: Record "BCS Bot Instance"; var PriceToCharge: Decimal)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGeneratePOLineSetQuantity(var PurchaseLine: Record "Purchase Line"; var BotInstance: Record "BCS Bot Instance"; var QuantityToOrder: Decimal)
    begin
    end;

    procedure GetResult(var DispatchResult: Record "BCS Dispatch Result" temporary)
    begin
        Clear(DispatchResult);
        DispatchResult.TransferFields(MyResult);
    end;

    procedure SetResult(newText: Text[200]; whichType: Enum "BCS Bot Result Type")
    begin
        MyResult."Action Type" := whichType;
        MyResult.ResultText := newText;
    end;


    var
        MyResult: Record "BCS Dispatch Result" temporary;
        POCreatedMsg: Label 'Purch. Order %1 created for Vendor No. %2.';
        NoOrdersNeededMsg: Label 'No orders are required from Vendor No. %1.';
        MaxOrdersPerDayReachedMsg: Label 'Vendor No. %1 already has %2 orders for that date.';
}
