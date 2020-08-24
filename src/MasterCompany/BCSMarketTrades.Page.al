page 88023 "BCS Market Trades"
{

    ApplicationArea = All;
    Caption = 'BCS Market Trades';
    PageType = List;
    SourceTable = "BCS Market Trades";
    UsageCategory = History;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field(Company; Company)
                {
                    ApplicationArea = All;
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                }
                field("Total Trades"; "Total Trades")
                {
                    ApplicationArea = All;
                }
                field(Price; Price)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
