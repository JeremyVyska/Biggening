page 88009 "BCS Bot Activity Log"
{

    ApplicationArea = All;
    Caption = 'BCS Bot Activity Log';
    PageType = List;
    SourceTable = "BCS Bot Activity Log";
    UsageCategory = History;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Activity Type"; "Activity Type")
                {
                    ApplicationArea = All;
                }
                field("Bot Instance"; "Bot Instance")
                {
                    ApplicationArea = All;
                }
                field("Bot Type"; "Bot Type")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
