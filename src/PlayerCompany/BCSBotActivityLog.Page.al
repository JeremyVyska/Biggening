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
                    ToolTip='Specifies the value of the Entry No. field';
                }
                field("Activity Type"; "Activity Type")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Activity Type field';
                }
                field("Bot Instance"; "Bot Instance")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Bot Instance field';
                }
                field("Bot Type"; "Bot Type")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Bot Type field';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Posting Date field';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Description field';
                }
            }
        }
    }

}
