page 88017 "BCS Prospect Trade Factbox"
{

    Caption = 'BCS Prospect Trade Factbox';
    PageType = ListPart;
    SourceTable = "BCS Prospect Trades";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Trade Code"; "Trade Code")
                {
                    ApplicationArea = All;
                }
                field("Trade Type"; "Trade Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
