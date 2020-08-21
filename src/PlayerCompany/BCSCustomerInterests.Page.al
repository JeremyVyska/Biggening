page 88024 "BCS Customer Interests"
{
    
    Caption = 'BCS Customer Interests';
    PageType = ListPart;
    SourceTable = "BCS Customer Interest";
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Prod. Posting Group"; "Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    
}
