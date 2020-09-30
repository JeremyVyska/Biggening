page 88003 "BCS Player Activities"
{
    Caption = 'Player Activities';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = "BCS Player Cue";
    ShowFilter = false;

    layout
    {
        area(Content)
        {
            cuegroup(Insights)
            {
                CuegroupLayout = Wide;
                field(Wealth; Wealth)
                {
                    ApplicationArea = All;
                    Caption = 'Current Wealth';
                    ToolTip='Specifies the value of the Current Wealth field';

                    trigger OnDrillDown()
                    begin
                        DrillDownWealth();
                    end;
                }

                field("Idling Bots"; "Idling Bots")
                {
                    Caption = 'Idling Bots';
                    ApplicationArea = All;
                      ToolTip='Specifies the value of the Idling Bots field';

                    trigger OnDrillDown()
                    var
                        WhichFilter: Enum "BCS Bot Result Type";
                    begin
                        DrillDownBots(WhichFilter::Idle);
                    end;
                }
                field("Erroring Bots"; "Erroring Bots")
                {
                    Caption = 'Erroring Bots';
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Erroring Bots field';

                    trigger OnDrillDown()
                    var
                        WhichFilter: Enum "BCS Bot Result Type";
                    begin
                        DrillDownBots(WhichFilter::Error);
                    end;
                }
            }
            cuegroup("Situations")
            {
                field("Bot Errors"; "Bot Errors")
                {
                    Caption = 'Bot Errors';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "BCS Bot Error Log";
                    ToolTip = 'Current count of new bot related errors';
                }
                field("Delayed Shipments"; "Delayed Shipments")
                {
                    Caption = 'Delayed Shipments';
                    ApplicationArea = all;
                    ToolTip='Specifies the value of the Delayed Shipments field';
                }
                field("Delayed Receipts"; "Delayed Receipts")
                {
                    Caption = 'Delayed Receipts';
                    ApplicationArea = all;
                    ToolTip='Specifies the value of the Delayed Receipts field';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Reset();
        If not Get() then begin
            Init();
            Insert();
        end;

    end;

    trigger OnAfterGetRecord()
    begin
        CalculateCueFieldValues();
    end;

    local procedure CalculateCueFieldValues()
    begin
        CalculateNonFlowFields();
    end;

}