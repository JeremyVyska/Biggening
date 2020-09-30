pageextension 88009 "BCS Item List" extends "Item List"
{
    layout
    {
        modify("Substitutes Exist")
        {
            Visible = false;
        }
        modify("Base Unit of Measure")
        {
            Visible = false;
        }
        modify("Cost is Adjusted")
        {
            Visible = false;
        }
        modify("Unit Price")
        {
            Visible = false;
        }
        modify("Vendor No.")
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        modify("Assembly BOM")
        {
            Visible = false;
        }
        modify("Production BOM No.")
        {
            Visible = false;
        }
        modify("Routing No.")
        {
            Visible = false;
        }

        addafter(InventoryField)
        {
            field("BCS Reorder Level"; "BCS Reorder Level")
            {
                ApplicationArea = All;
                ToolTip='Specifies the value of the BCS Reorder Level field';
            }
        }

        addafter("Unit Cost")
        {
            field(BCSMarketPrice; MarketPrice)
            {
                Caption = 'Market Price';
                Editable = false;
                DecimalPlaces = 0 : 0;
                ToolTip='Specifies the value of the Market Price field';
            }
            field("BCS Min. Sales Price."; "BCS Min. Sales Price.")
            {
                Caption = 'Minimum Sales Price';
                ApplicationArea = All;
                ToolTip='Specifies the value of the Minimum Sales Price field';
            }

        }
    }

    trigger OnAfterGetRecord()
    var
        MarketPrices: Record "BCS Market Price";
    begin
        Clear(MarketPrice);
        if MarketPrices.Get(Rec."No.") then
            MarketPrice := MarketPrices."Market Price";
    end;

    var
        MarketPrice: Decimal;
}