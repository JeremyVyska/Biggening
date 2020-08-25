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
                group(PlayerPurchase)
                {
                    Caption = 'Purchasing';

                    field("BCS Reorder Level"; "BCS Reorder Level")
                    {
                        ApplicationArea = All;
                    }
                    field("BCS Maximum Stock"; "BCS Maximum Stock")
                    {
                        ApplicationArea = All;
                    }
                    field("BCS Max. Purch Price."; "BCS Max. Purch Price.")
                    {
                        ApplicationArea = All;
                    }

                }
                group(PlayerSales)
                {
                    field("BCS Min. Sales Price."; "BCS Min. Sales Price.")
                    {
                        ApplicationArea = All;
                    }

                }
            }
        }

        addlast(factboxes)
        {
            part(BCSMarketPrice; "BCS Market Price")
            {
                Caption = 'Market Price';
                SubPageLink = "Item No." = field("No.");
            }
        }
    }
}