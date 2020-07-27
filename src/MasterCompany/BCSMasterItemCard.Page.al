page 88014 "BCS Master Item Card"
{
    Caption = 'BCS Master Item Card';
    PageType = Card;
    SourceTable = "BCS Master Item";

    layout
    {
        area(content)
        {
            group(General)
            {
                field(Code; Code)
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
            }

            part(BOM; "BCS Master Item Subpage")
            {
                SubPageLink = "Item No." = field(Code);
                UpdatePropagation = both;
            }
        }
    }

}
