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
                }
                field("Player No."; "Player No.")
                {
                    ApplicationArea = All;
                }
                field("Game Date"; "Game Date")
                {
                    ApplicationArea = All;
                }
                field("Customer Counts"; "Customer Counts")
                {
                    ApplicationArea = All;
                }

                field("Location Counts"; "Location Counts")
                {
                    ApplicationArea = All;
                }

                field("Power Usage"; "Power Usage")
                {
                    ApplicationArea = All;
                }

                field("Vendor Counts"; "Vendor Counts")
                {
                    ApplicationArea = All;
                }
                field("Wealth Balance"; "Wealth Balance")
                {
                    ApplicationArea = All;
                }
                field("Wealth Net Change"; "Wealth Net Change")
                {
                    ApplicationArea = All;
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
