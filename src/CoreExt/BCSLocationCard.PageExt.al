pageextension 88006 "BCS Location Card" extends "Location Card"
{
    layout
    {
        addafter(General)
        {
            group(PlayerInfo)
            {
                Caption = 'Player Information';

                field("Upgrade Code"; "Upgrade Code")
                {
                    ApplicationArea = All;
                }
                field("Maximum Bots"; "Maximum Bots")
                {
                    ApplicationArea = All;
                }
                field("Assigned Bots"; "Assigned Bots")
                {
                    ApplicationArea = All;
                }
                field("Maximum Units"; "Maximum Units")
                {
                    ApplicationArea = All;
                }
                field("Total Stock"; "Total Stock")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}