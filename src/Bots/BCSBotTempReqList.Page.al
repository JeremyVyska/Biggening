page 88026 "BCS Bot Temp. Req. List"
{

    Caption = 'BCS Bot Temp. Req. List';
    PageType = List;
    SourceTable = "BCS Bot Template Req.";
    UsageCategory = None;
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Master Item No."; "Master Item No.")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Master Item No. field';
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
