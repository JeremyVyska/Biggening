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

        if BotTotal <> 0 then begin
            OnBeforeChargePower(PowerLedger."Entry Type", BotTotal, IsHandled);
            if not IsHandled then
                if DoPostLine(GameSetup."Bot Power Account", BotTotal) then begin
                    PowerLedger.SetRange("Entry Type", PowerLedger."Entry Type"::Bot);
                    PowerLedger.ModifyAll("Posted to G/L", true);
                end;
        end;
        if LocTotal <> 0 then begin
            OnBeforeChargePower(PowerLedger."Entry Type", LocTotal, IsHandled);
            if not IsHandled then
                if DoPostLine(GameSetup."Loc. Power Account", LocTotal) then begin
                    PowerLedger.SetRange("Entry Type", PowerLedger."Entry Type"::Location);
                    PowerLedger.ModifyAll("Posted to G/L", true);
                end;
        end;
    end;

    procedure DoPostLine(ChargeAccount: Code[20]; ChargeAmount: Decimal): Boolean
    var
        GenJnl: Record "Gen. Journal Line";
        GenJnlPost: Codeunit "Gen. Jnl.-Post Line";
    begin
        GenJnl."Journal Template Name" := 'GENERAL';
        GenJnl."Journal Batch Name" := 'DEFAULT';
        GenJnl."Line No." := 10000;
        GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
        GenJnl.Validate("Account No.", ChargeAccount);
        GenJnl.Validate("Document No.", StrSubstNo(PowerDocNoTok, Format(WorkDate(), 0, '<Standard Format,9>')));
        GenJnl.Validate("Posting Date", WorkDate());
        GenJnl.Validate("Bal. Account Type", GenJnl."Bal. Account Type"::"G/L Account");
        GenJnl.Validate("Bal. Account No.", GameSetup."Cash Account");
        GenJnl.Validate(Amount, ChargeAmount);
        GenJnl.Insert(true);
        Commit();
        exit(GenJnlPost.Run(GenJnl));
    end;

    [BusinessEvent(false)]
    local procedure OnBeforeChargePower(ChargeType: Option Bot,Location; var ChargeAmount: Decimal; var IsHandled: Boolean)
    begin
    end;


    var
        GameSetup: Record "BCS Game Setup";
        PowerDocNoTok: Label 'PWR-%1';
}
