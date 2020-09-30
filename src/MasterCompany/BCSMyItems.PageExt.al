pageextension 88010 "BCS My Items" extends "My Items"
{
    layout
    {
        addlast(Control1)
        {
            field(MarketPrice; MarketPrice)
            {
                ApplicationArea = all;
                ToolTip='Specifies the value of the MarketPrice field';
            }
        }
    }

    var
        MarketPrice: Decimal;
}
