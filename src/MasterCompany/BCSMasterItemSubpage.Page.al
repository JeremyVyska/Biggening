page 88013 "BCS Master Item Subpage"
{

    Caption = 'BCS Master Item Subpage';
    PageType = ListPart;
    SourceTable = "BCS Master Item BOM";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Master Component No."; "Master Component No.")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
