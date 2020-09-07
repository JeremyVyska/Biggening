table 88002 "BCS Player Cue"
{
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {
            DataClassification = SystemMetadata;
        }

        field(100; "Total Bot Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("BCS Bot Instance");
            Editable = false;
        }

        field(101; "Bot Errors"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("BCS Bot Error Log" where("Error Type" = const(PlayerError), Acknowledged = const(false)));
            Editable = false;
        }

        // Wealth Balance
        field(200; "Wealth"; Decimal)
        {
            Caption = 'Wealth';
            DataClassification = SystemMetadata;
        }

        // Bots - Idle, Erroring
        field(300; "Idling Bots"; Integer)
        {
            Caption = 'Idling Bots';
            DataClassification = SystemMetadata;
        }

        field(310; "Erroring Bots"; Integer)
        {
            Caption = 'Erroring Bots';
            DataClassification = SystemMetadata;
        }


        field(400; "Delayed Date Filter"; Date)
        {
            Caption = 'Delayed Date Filter';
            FieldClass = FlowFilter;
        }

        // Delayed Shipments
        field(410; "Delayed Shipments"; Integer)
        {
            Caption = 'Delayed Shipments';
            FieldClass = FlowField;
            CalcFormula = count ("Sales Header" where("Document Type" = const(Order), Status = const(Open), "Document Date" = field("Delayed Date Filter")));
        }

        // Delayed Receipts
        field(420; "Delayed Receipts"; Integer)
        {
            Caption = 'Delayed Receipts';
            FieldClass = FlowField;
            CalcFormula = count ("Purchase Header" where("Document Type" = const(Order), Status = const(Open), "Document Date" = field("Delayed Date Filter")));
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure CalculateNonFlowFields()
    var
        GameSetup: Record "BCS Game Setup";
        GLAccount: Record "G/L Account";
        BotInstance: Record "BCS Bot Instance";
        BotActLog: Record "BCS Bot Activity Log";
    begin
        GameSetup.Get();
        if GLAccount.Get(GameSetup."Wealth Account") then begin
            GLAccount.CalcFields(Balance);
            Wealth := GLAccount.Balance;
        end else
            Wealth := 0;

        // TODO: Query
        "Idling Bots" := 0;
        "Erroring Bots" := 0;
        if BotInstance.FindSet() then
            repeat
                BotActLog.Reset();
                BotActLog.SetRange("Bot Instance", BotInstance."Instance ID");
                BotActLog.SetFilter("Posting Date", '%1..', CalcDate('<-30D>', WorkDate()));

                BotActLog.SetRange("Activity Type", BotActLog."Activity Type"::Idle);
                if not BotActLog.IsEmpty then
                    "Idling Bots" := "Idling Bots" + 1;

                BotActLog.SetRange("Activity Type", BotActLog."Activity Type"::Error);
                if not BotActLog.IsEmpty then
                    "Erroring Bots" := "Erroring Bots" + 1;
            until BotInstance.Next() = 0;
    end;

    procedure DrillDownWealth()
    var
        GLAccount: Record "G/L Account";
        GameSetup: Record "BCS Game Setup";
        ChartOfAcc: Page "Chart of Accounts";
    begin
        GameSetup.Get();
        GLAccount.SetFilter("No.", '..%1', GameSetup."Wealth Account");
        ChartOfAcc.SetTableView(GLAccount);
        ChartOfAcc.Run();
    end;

    procedure DrillDownBots(WhichStatus: Enum "BCS Bot Result Type")
    var
        BotInstance: Record "BCS Bot Instance";
        BotActLog: Record "BCS Bot Activity Log";
        BotList: Page "BCS Bot Instance List";
    begin
        if BotInstance.FindSet() then
            repeat
                BotActLog.Reset();
                BotActLog.SetRange("Bot Instance", BotInstance."Instance ID");
                BotActLog.SetFilter("Posting Date", '%1..', CalcDate('<-30D>', WorkDate()));

                BotActLog.SetRange("Activity Type", WhichStatus);
                BotInstance.Mark(not BotActLog.IsEmpty);
            until BotInstance.Next() = 0;

        BotInstance.MarkedOnly(true);
        BotList.SetTableView(BotInstance);
        BotList.Run();
    end;
}