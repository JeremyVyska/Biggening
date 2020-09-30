page 88022 "BCS Snapshot Bot Listpart"
{

    Caption = 'BCS Snapshot Bot Listpart';
    PageType = ListPart;
    SourceTable = "BCS Snapshot Bots";
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bot Type"; "Bot Type")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Bot Type field';
                }
                field("Bot Count"; "Bot Count")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Bot Count field';
                }
            }
        }
    }

}
