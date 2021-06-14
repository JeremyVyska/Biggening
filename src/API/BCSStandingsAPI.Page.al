page 88034 "BCS Standings API"
{

    APIGroup = 'biggening';
    APIPublisher = 'sparebrained';
    APIVersion = 'v1.0';
    Caption = 'bCSStandingsAPI';
    DelayedInsert = true;
    EntityName = 'standing';
    EntitySetName = 'standings';
    PageType = API;
    SourceTable = "BCS Snapshot";
    SourceTableView = sorting("Season No.", "Rank at Date");

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(playerCompanyName; playerCompanyName)
                {
                    Caption = 'playerCompanyName', Locked = true;
                }
                field(rankatDate; Rec."Rank at Date")
                {
                    Caption = 'rank', Locked = true;
                }
                field(wealthBalance; Rec."Wealth Balance")
                {
                    Caption = 'wealthBalance', Locked = true;
                }

                field(priorDateRank; priorDateRank)
                {
                    Caption = 'priorDateRank', Locked = true;
                }
                field(priorDateWealth; priorDateWealth)
                {
                    Caption = 'priorDateWealth', Locked = true;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        BCSSeason: Record "BCS Season";
        BCSGameSetup: Record "BCS Game Setup";
    begin
        BCSSeason.SetRange(Active, true);
        BCSSeason.FindFirst();
        Rec.SetRange("Season No.", BCSSeason."No.");

        BCSGameSetup.Get();
        BCSGameSetup.TestField("Game Date");
        rec.SetRange("Game Date", BCSGameSetup."Game Date");
    end;

    trigger OnAfterGetRecord()
    var
        BCSSnapshot: Record "BCS Snapshot";
        BCSPlayer: Record "BCS Player";
    begin
        BCSSnapshot.SetRange("Season No.", Rec."Season No.");
        BCSSnapshot.SetRange("Player No.", Rec."Player No.");

        BCSSnapshot.SetRange("Game Date", CalcDate('<-1D>', Rec."Game Date"));
        if BCSSnapshot.FindFirst() then begin
            priorDateRank := BCSSnapshot."Rank at Date";
            priorDateWealth := BCSSnapshot."Wealth Balance";
        end else begin
            priorDateRank := 0;
            priorDateWealth := 0;
        end;

        BCSPlayer.Get(Rec."Player No.");
        BCSPlayer.calcfields("Company Display Name");
        playerCompanyName := BCSPlayer."Company Display Name";
    end;


    var
        priorDateRank: Integer;
        priorDateWealth: Decimal;
        playerCompanyName: Text[250];
}
