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
                }
                field(Prerequisite; Prerequisite)
                {
                    ApplicationArea = All;
                }
                field("Master Item No."; "Master Item No.")
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
