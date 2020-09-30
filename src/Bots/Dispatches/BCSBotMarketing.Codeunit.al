codeunit 88013 "BCS Bot Marketing"
{
    TableNo = "BCS Bot Instance";

    trigger OnRun()
    var
        i: Integer;
        GeneratedProspects: Integer;
    begin
        // Safety Measure
        if (Rec."Bot Tier" = 0) then begin
            Rec."Bot Tier" := 1;
            Rec.Modify(true);
        end;
        for i := 1 to Rec.GetOpsPerDay() do
            // For now, marketing bots will Only fish for Customer Prospects
            GeneratedProspects := GeneratedProspects + FishForProspect(Rec);

        SetResult(StrSubstNo('I marketed and found %1 prospects today.', GeneratedProspects), MyResult."Action Type"::Activity);
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
        Template: Record "BCS Bot Template";
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
        GameSetup.TestField("Sales Prospect Effort");
        GameSetup.TestField("Sales Pros. Base Max Orders");
        GameSetup.TestField("Sales Pros. Base Max Quantity");
        GameSetup.TestField("Sales Pros. Tier Multiplier");

        Template.Get(whichBot."Bot Template Code");
        Template.TestField("Marketing Bot Item Tier");

        CompanyInfo."Sales Prospect Effort" := CompanyInfo."Sales Prospect Effort" + whichBot.GetOpsPerDay();
        CompanyInfo.Modify(false);

        if (CompanyInfo."Sales Prospect Effort" > GameSetup."Sales Prospect Effort") then begin
            Prospect.Type := Prospect.Type::Customer;
            GetRandomName(Prospect);
            Prospect."Maximum Orders Per Day" := Round(GameSetup."Sales Pros. Base Max Orders" * (whichBot."Bot Tier" * GameSetup."Sales Pros. Tier Multiplier"));
            Prospect."Maximum Quantity Per Order" := Round(GameSetup."Sales Pros. Base Max Quantity" * (whichBot."Bot Tier" * GameSetup."Sales Pros. Tier Multiplier"));
            Prospect.Insert(true);
            Generated := Generated + 1;

            MasterItem.SetRange("Prod. Posting Group", Template."Marketing Bot Item Tier");
            IfRunTrigger := true;
            OnBeforeProspectTrades(Prospect, MasterItem, IfRunTrigger);
            if IfRunTrigger then
                for i := 1 to whichBot."Bot Tier" do begin
                    j := 0;
                    TempMasterItem.Reset();

                    // Randomly select items from that Prod. Posting Group tier
                    // with duplication detecting
                    repeat
                        if MasterItem.FindFirst() then
                            MasterItem.Next(Random(MasterItem.Count) - 1);
                        j := j + 1
                    until ((not TempMasterItem.Get(MasterItem."No.")) or (j > 20));

                    if TempMasterItem."No." = '' then begin
                        TempMasterItem := MasterItem;
                        TempMasterItem.Insert(false);

                        Trades."Prospect No." := Prospect."No.";
                        Trades."Item No." := MasterItem."No.";
                        Trades."Prod. Posting Group" := MasterItem."Prod. Posting Group";
                        Trades."Item Category Code" := MasterItem."Item Category Code";
                        Trades.Insert(true);
                        //NOTE: This DOES mean the player can get Customer Prospects that
                        //      want items they haven't yet unlocked.  This is acceptable to
                        //      me, since that will show them towards unlocking new items.
                        //      Code in the Prospect conversion watches for that.
                    end else
                        Error('');
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
}
