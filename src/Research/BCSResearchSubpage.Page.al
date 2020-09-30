page 88012 "BCS Research Subpage"
{
    Caption = 'BCS Research Subpage';
    PageType = ListPart;
    SourceTable = "BCS Research Prereq.";
    AutoSplitKey = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Requirement Type"; "Requirement Type")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Requirement Type field';
                }
                field(Prerequisite; Prerequisite)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Prerequisite field';
                }
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
