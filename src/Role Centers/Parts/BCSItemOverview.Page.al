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
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Inventory; Inventory)
                {
                    ApplicationArea = All;
                }
                field("BCS Maximum Stock"; "BCS Maximum Stock")
                {
                    ApplicationArea = All;
                }
                field("BCS Min. Sales Price."; "BCS Min. Sales Price.")
                {
                    ApplicationArea = All;
                }
                field(BCSMarketPrice; MarketPrice)
                {
                    Caption = 'Market Price';
                    Editable = false;
                    DecimalPlaces = 0 : 0;
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
