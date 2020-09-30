page 88025 "BCS Market Price"
{

    Caption = 'BCS Market Price';
    PageType = CardPart;
    SourceTable = "BCS Market Price";

    layout
    {
        area(content)
        {
            field("Market Price"; "Market Price")
            {
                ApplicationArea = All;
                ToolTip='Specifies the value of the Market Price field';
            }
        }
    }

}
