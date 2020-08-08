pageextension 88004 "BCS Item Card" extends "Item Card"
{
    layout
    {
        modify("Service Item Group")
        {
            Visible = false;
        }
        modify("Automatic Ext. Texts")
        {
            Visible = false;
        }
        modify(Blocked)
        {
            Visible = false;
        }
        modify(GTIN)
        {
            Visible = false;
        }
        modify(Type)
        {
            Visible = false;
        }
        modify("Common Item No.")
        {
            Visible = false;
        }
        modify("Purchasing Code")
        {
            Visible = false;
        }

        addafter(Item)
        {
            group(PlayerInfo)
            {
                Caption = 'Player Information & Settings';
                field("BCS Reorder Level"; "BCS Reorder Level")
                {
                    ApplicationArea = All;
                }
                field("BCS Maximum Stock"; "BCS Maximum Stock")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}