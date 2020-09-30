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
                    ToolTip='Specifies the value of the Item No. field';
                }
                field(Company; Company)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Company field';
                }
                field(Date; Date)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Date field';
                }
                field("Total Trades"; "Total Trades")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Total Trades field';
                }
                field(Price; Price)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Price field';
                }
            }
        }
    }

}
