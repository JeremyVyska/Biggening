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

                    trigger OnDrillDown()
                    begin
                        DrillDownWealth();
                    end;
                }

                field("Idling Bots"; "Idling Bots")
                {
                    Caption = 'Idling Bots';
                    ApplicationArea = All;

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
                }
                field("Delayed Receipts"; "Delayed Receipts")
                {
                    Caption = 'Delayed Receipts';
                    ApplicationArea = all;
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