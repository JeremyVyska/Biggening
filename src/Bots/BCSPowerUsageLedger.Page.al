page 88008 "BCS Power Usage Ledger"
{

    ApplicationArea = All;
    Caption = 'BCS Power Usage Ledger';
    PageType = List;
    SourceTable = "BCS Power Ledger";
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
                field("Bot Instance"; "Bot Instance")
                {
                    ApplicationArea = All;
                }
                field("Bot Type"; "Bot Type")
                {
                    ApplicationArea = All;
                }
                field("Posted to G/L"; "Posted to G/L")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Power Usage"; "Power Usage")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
