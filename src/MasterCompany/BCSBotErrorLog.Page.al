page 88010 "BCS Bot Error Log"
{

    ApplicationArea = All;
    Caption = 'BCS Bot Error Log';
    PageType = List;
    SourceTable = "BCS Bot Error Log";
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

                field("Company Name"; "Company Name")
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
                field("Error Message"; "Error Message")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
