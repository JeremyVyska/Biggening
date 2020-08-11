codeunit 88006 "BCS Bot Purchase"
{
    TableNo = "BCS Bot Instance";

    trigger OnRun()
    var
        Documents: List of [Code[20]];
        DocListBuilder: TextBuilder;
        DocNo: Text;
        i: Integer;
    begin
        //Error('Hello Stream!');
        //ResultText := StrSubstNo('In the future, I would make %1 purchases.', Rec."Operations Per Day");

        if (Rec."Bot Tier" = 0) then begin
            Rec."Bot Tier" := 1;
            Rec.Modify(true);
        end;

        for i := 1 to Rec.GetOpsPerDay() do begin
            // If the Purchasing Bot is assigned:
            if Rec."Assignment Code" <> '' then
                Documents.Add(CreatePO(Rec."Assignment Code"))
            else
                // Else, they will 'farm' for new suppliers
                FishForProspect(Rec);
        end;

        if Rec."Assignment Code" <> '' then begin

            //TODO: Count of Released PO's, if any, POST BATCH on Status = Released.
            foreach DocNo in Documents do
                DocListBuilder.Append(DocNo + ', ');
            DocListBuilder.Remove(DocListBuilder.Length - 2, 2);
            Commit();
            foreach DocNo in Documents do begin
                PostPO(DocNo);
                Commit();
            end;
            ResultText := StrSubstNo('%1: %2', Documents.Count, DocListBuilder.ToText());
        end;
    end;

    procedure GetResultText(): Text[200]
    begin
        exit(ResultText);
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

    local procedure CreatePO(VendorNo: Code[20]): Code[20]
    var
        PurchaseHeader: Record "Purchase Header";
    begin
        // Count of BOTH The open PO docs, and the posted docs

        PurchaseHeader.Validate("Document Type", PurchaseHeader."Document Type"::Order);
        PurchaseHeader.Validate("Buy-from Vendor No.", VendorNo);
        PurchaseHeader.Insert(true);

        //Testing, just one
        CreateLine(PurchaseHeader);

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

    local procedure CreateLine(var PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        NextLineNo: Integer;
    begin
        //Later, NextLineNo ?
        NextLineNo := 10000;

        PurchaseLine.Validate("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.Validate("Document No.", PurchaseHeader."No.");
        PurchaseLine.Validate("Line No.", NextLineNo);
        PurchaseLine.Insert(true);
        PurchaseLine.Validate(Type, PurchaseLine.Type::Item);
        PurchaseLine.Validate("No.", '1000');
        PurchaseLine.Validate(Quantity, Random(10) + 10);
        PurchaseLine.validate("Direct Unit Cost", Random(10) + 10);
        PurchaseLine.Modify(true);
    end;

    /*

8888888b.                   888         8888888b.   .d88888b.  
888   Y88b                  888         888   Y88b d88P" "Y88b 
888    888                  888         888    888 888     888 
888   d88P .d88b.  .d8888b  888888      888   d88P 888     888 
8888888P" d88""88b 88K      888         8888888P"  888     888 
888       888  888 "Y8888b. 888         888        888     888 
888       Y88..88P      X88 Y88b.       888        Y88b. .d88P 
888        "Y88P"   88888P'  "Y888      888         "Y88888P"  

*/

    local procedure PostPO(PurchaseOrderNo: Code[20])
    var
        PurchaseHeader: Record "Purchase Header";
        PurchPost: Codeunit "Purch.-Post";
    begin
        if PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrderNo) then begin
            PurchaseHeader.Receive := true;
            PurchaseHeader.Invoice := true;
            PurchPost.SetPostingFlags(PurchaseHeader);
            PurchPost.Run(PurchaseHeader);
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

    local procedure FishForProspect(whichBot: Record "BCS Bot Instance")
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

            // Trade Creation
            MasterItem.SetRange("Prod. Posting Group", 'CLASS1');
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
                    until ((not TempMasterItem.Get(MasterItem.Code)) or (j > 20));
                    if TempMasterItem.Code = '' then begin
                        TempMasterItem := MasterItem;
                        TempMasterItem.Insert(false);

                        Trades.Reset();
                        Trades."Prospect No." := Prospect."No.";
                        Trades."Trade Type" := Trades."Trade Type"::Item;
                        Trades."Trade Code" := MasterItem.Code;
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

    var
        ResultText: Text[200];
}
