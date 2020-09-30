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
                    ToolTip='Specifies the value of the Item No. field';
                }
                field("Line No."; "Line No.")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip='Specifies the value of the Line No. field';
                }
                field("Master Component No."; "Master Component No.")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Master Component No. field';
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Quantity field';
                }
            }
        }
    }

}
