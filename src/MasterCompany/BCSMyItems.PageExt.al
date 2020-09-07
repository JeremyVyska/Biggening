pageextension 88010 "BCS My Items" extends "My Items"
{
    layout
    {
        addlast(Control1)
        {
            field(MarketPrice; MarketPrice)
            {
                ApplicationArea = all;
            }
        }
    }

    var
        MarketPrice: Decimal;
}
