page 88033 "BCS Standings Overview"
{

    Caption = 'BCS Standings Overview';
    PageType = ListPart;
    SourceTable = "BCS Snapshot";
    SourceTableView = sorting("Game Date", "Wealth Balance") order(descending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Rank at Date"; "Rank at Date")
                {
                    Caption = 'Rank';
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Rank field';
                }

                field(DisplayName; DisplayName)
                {
                    Caption = 'Company';
                    ApplicationArea = All;
                     ToolTip='Specifies the value of the Company field';
                }
                field("Wealth Balance"; "Wealth Balance")
                {
                    Caption = 'Wealth';
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Wealth field';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        GameSetup: Record "BCS Game Setup";
    begin
        GameSetup.Get();
        Rec.SetRange("Game Date", GameSetup."Game Date");
    end;

    trigger OnAfterGetRecord()
    var
        Players: Record "BCS Player";
    begin
        Players.Get(Rec."Player No.");
        Players.CalcFields("Company Display Name");
        DisplayName := Players."Company Display Name";
    end;

    var
        DisplayName: Text;
}
