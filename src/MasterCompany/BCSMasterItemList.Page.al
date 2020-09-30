page 88015 "BCS Master Item List"
{

    ApplicationArea = All;
    Caption = 'BCS Master Item List';
    PageType = List;
    SourceTable = "BCS Master Item";
    UsageCategory = Lists;
    CardPageId = "BCS Master Item Card";

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
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Item Category Code field';
                }
                field("Prod. Posting Group"; "Prod. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Prod. Posting Group field';
                }
                field("Initial Price"; "Initial Price")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Initial Price field';
                }
                field("Available at Start"; "Available at Start")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Available at Start field';
                }
            }
        }
    }

}
