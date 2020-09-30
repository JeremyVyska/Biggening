pageextension 88004 "BCS Item Card" extends "Item Card"
{
    layout
    {
        modify(Item)
        {
            Editable = IsAdmin;
        }
        modify(InventoryGrp)
        {
            Editable = IsAdmin;
        }
        modify("Costs & Posting")
        {
            Editable = IsAdmin;
        }
        modify("Prices & Sales")
        {
            Editable = IsAdmin;
        }
        modify(Replenishment)
        {
            Editable = IsAdmin;
        }
        modify(Planning)
        {
            Editable = IsAdmin;
        }
        modify(ItemTracking)
        {
            Editable = IsAdmin;
        }
        modify(Warehouse)
        {
            Editable = IsAdmin;
        }
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
                          ToolTip='Specifies the value of the BCS Reorder Level field';
                    }
                    field("BCS Maximum Stock"; "BCS Maximum Stock")
                    {
                        ApplicationArea = All;
                        ToolTip='Specifies the value of the BCS Maximum Stock field';
                    }
                    field("BCS Max. Purch Price."; "BCS Max. Purch Price.")
                    {
                        ApplicationArea = All;
                        ToolTip='Specifies the value of the BCS Max. Purch Price. field';
                    }

                }
                group(PlayerSales)
                {
                    field("BCS Min. Sales Price."; "BCS Min. Sales Price.")
                    {
                        ApplicationArea = All;
                        ToolTip='Specifies the value of the BCS Min. Sales Price. field';
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

    trigger OnOpenPage()
    begin
        IsAdmin := PlayerMgmt.SetIsAdmin();
    end;

    var
        PlayerMgmt: Codeunit "BCS Player Management";
        IsAdmin: Boolean;
}