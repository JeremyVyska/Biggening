page 88014 "BCS Master Item Card"
{
    Caption = 'BCS Master Item Card';
    PageType = Card;
    SourceTable = "BCS Master Item";
    UsageCategory = None;

    layout
    {
        area(content)
        {
            group(General)
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

            part(BOM; "BCS Master Item Subpage")
            {
                SubPageLink = "Item No." = field("No.");
                UpdatePropagation = both;
            }
        }
    }

}
