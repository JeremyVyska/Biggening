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
            cuegroup("Bots")
            {
                field("Total Bot Count"; "Total Bot Count")
                {
                    Caption = 'Bot Count';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "BCS Bot Instance List";
                    ToolTip = 'Current count of bots the company operates';
                }
                field("Bot Errors"; "Bot Errors")
                {
                    Caption = 'Bot Errors';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "BCS Bot Error Log";
                    ToolTip = 'Current count of new bot related errors';
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

    end;

}