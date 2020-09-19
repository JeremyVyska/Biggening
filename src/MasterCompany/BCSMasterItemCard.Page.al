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
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Prod. Posting Group"; "Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Initial Price"; "Initial Price")
                {
                    ApplicationArea = All;
                }
                field("Available at Start"; "Available at Start")
                {
                    ApplicationArea = All;
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
