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
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Item No. field';
                }
                field("Prod. Posting Group"; "Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Prod. Posting Group field';
                }
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Item Category Code field';
                }
            }
        }
    }

}
