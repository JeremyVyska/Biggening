page 88021 "BCS Snapshot List"
{

    ApplicationArea = All;
    Caption = 'BCS Snapshot List';
    PageType = List;
    SourceTable = "BCS Snapshot";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Season No."; "Season No.")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Season No. field';
                }
                field("Player No."; "Player No.")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Player No. field';
                }
                field("Game Date"; "Game Date")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Game Date field';
                }
                field("Customer Counts"; "Customer Counts")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Customer Counts field';
                }

                field("Location Counts"; "Location Counts")
                {
                    ApplicationArea = All;
                     ToolTip='Specifies the value of the Location Counts field';
                }

                field("Power Usage"; "Power Usage")
                {
                    ApplicationArea = All;
                     ToolTip='Specifies the value of the Power Usage field';
                }

                field("Vendor Counts"; "Vendor Counts")
                {
                    ApplicationArea = All;
                     ToolTip='Specifies the value of the Vendor Counts field';
                }
                field("Wealth Balance"; "Wealth Balance")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Wealth Balance field';
                }
                field("Wealth Net Change"; "Wealth Net Change")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Wealth Net Change field';
                }
            }
        }
        area(FactBoxes)
        {
            part(BCSBotList; "BCS Snapshot Bot Listpart")
            {
                Caption = 'Bots By Type';
                SubPageLink = "Season No." = field("Season No."), "Player No." = field("Player No."), "Game Date" = field("Game Date");
            }
        }
    }


}
