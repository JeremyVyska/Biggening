codeunit 88013 "BCS Bot Marketing"
{
    TableNo = "BCS Bot Instance";

    trigger OnRun()
    var
        i: Integer;
    begin
        // Safety Measure
        if (Rec."Bot Tier" = 0) then begin
            Rec."Bot Tier" := 1;
            Rec.Modify(true);
        end;
        for i := 1 to Rec.GetOpsPerDay() do begin
            // For now, marketing bots will Only fish for Customer Prospects
            FishForProspect(Rec);
        end;

        // TODO: Return useful info to the Activity log
        ResultText := StrSubstNo('In the future, I would make %1 marketing ops.', Rec."Operations Per Day");
    end;

    procedure GetResultText(): Text[200]
    begin
        exit(ResultText);
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
        GameSetup.TestField("Sales Prospect Effort");
        GameSetup.TestField("Sales Pros. Base Max Orders");
        GameSetup.TestField("Sales Pros. Base Max Quantity");
        GameSetup.TestField("Sales Pros. Tier Multiplier");

        CompanyInfo."Sales Prospect Effort" := CompanyInfo."Sales Prospect Effort" + whichBot.GetOpsPerDay();
        CompanyInfo.Modify(false);

        if (CompanyInfo."Sales Prospect Effort" > GameSetup."Sales Prospect Effort") then begin
            Prospect.Type := Prospect.Type::Customer;
            GetRandomName(Prospect);
            Prospect."Maximum Orders Per Day" := Round(GameSetup."Sales Pros. Base Max Orders" * (whichBot."Bot Tier" * GameSetup."Sales Pros. Tier Multiplier"));
            Prospect."Maximum Quantity Per Order" := Round(GameSetup."Sales Pros. Base Max Quantity" * (whichBot."Bot Tier" * GameSetup."Sales Pros. Tier Multiplier"));
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
