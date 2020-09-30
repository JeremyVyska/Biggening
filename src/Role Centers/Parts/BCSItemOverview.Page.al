page 88031 "BCS Item Overview"
{

    Caption = 'BCS Item Overview';
    PageType = ListPart;
    SourceTable = Item;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the No. field';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Description field';
                }
                field(Inventory; Inventory)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Inventory field';
                }
                field("BCS Maximum Stock"; "BCS Maximum Stock")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the BCS Maximum Stock field';
                }
                field("BCS Min. Sales Price."; "BCS Min. Sales Price.")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the BCS Min. Sales Price. field';
                }
                field(BCSMarketPrice; MarketPrice)
                {
                    Caption = 'Market Price';
                    Editable = false;
                    DecimalPlaces = 0 : 0;
                    ToolTip='Specifies the value of the Market Price field';
                }
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
