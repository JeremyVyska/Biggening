codeunit 88023 "BCS Power Posting"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCS Player Heartbeat Listener", 'OnHeartbeat', '', true, true)]
    local procedure "BCS Player Heartbeat Listener_OnHeartbeat"()
    begin
        PostYesterdayPower();
    end;

    procedure PostYesterdayPower()
    var
        PowerLedger: Record "BCS Power Ledger";
        BCSPlayerCharge: Codeunit "BCS Player Charge";
        DocNo: Code[20];
        BotTotal: Decimal;
        LocTotal: Decimal;
        IsHandled: Boolean;
    begin
        GameSetup.Get();
        GameSetup.TestField("Cash Account");
        GameSetup.TestField("Bot Power Account");
        GameSetup.TestField("Loc. Power Account");
        PowerLedger.SetRange("Posted to G/L", false);
        PowerLedger.Setfilter("Posting Date", '..%1', CalcDate('<-1d>', WorkDate()));
        PowerLedger.SetRange("Entry Type", PowerLedger."Entry Type"::Bot);
        PowerLedger.CalcSums("Power Usage");
        BotTotal := PowerLedger."Power Usage";
        PowerLedger.SetRange("Entry Type", PowerLedger."Entry Type"::Location);
        PowerLedger.CalcSums("Power Usage");
        LocTotal := PowerLedger."Power Usage";
        DocNo := StrSubstNo(PowerDocNoTok, Format(WorkDate(), 0, '<Standard Format,9>'));

        if BotTotal <> 0 then begin
            OnBeforeChargePower(PowerLedger."Entry Type", BotTotal, IsHandled);
            if not IsHandled then
                if BCSPlayerCharge.ChargeCash(GameSetup."Bot Power Account", BotTotal, DocNo, PowerBotChargeTok) then begin
                    PowerLedger.SetRange("Entry Type", PowerLedger."Entry Type"::Bot);
                    PowerLedger.ModifyAll("Posted to G/L", true);
                end;
        end;
        if LocTotal <> 0 then begin
            OnBeforeChargePower(PowerLedger."Entry Type", LocTotal, IsHandled);
            if not IsHandled then
                if BCSPlayerCharge.ChargeCash(GameSetup."Loc. Power Account", LocTotal, DocNo, PowerLocationChargeTok) then begin
                    PowerLedger.SetRange("Entry Type", PowerLedger."Entry Type"::Location);
                    PowerLedger.ModifyAll("Posted to G/L", true);
                end;
        end;
    end;



    [BusinessEvent(false)]
    local procedure OnBeforeChargePower(ChargeType: Option Bot,Location; var ChargeAmount: Decimal; var IsHandled: Boolean)
    begin
    end;


    var
        GameSetup: Record "BCS Game Setup";
        PowerDocNoTok: Label 'PWR-%1', Comment = '%1 is an incrementing number';
        PowerBotChargeTok: Label 'Power charges for bots.';
        PowerLocationChargeTok: Label 'Power charges for locations';
}
