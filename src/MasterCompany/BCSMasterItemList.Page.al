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
        }
    }

}
