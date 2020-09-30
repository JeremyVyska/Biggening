page 88007 "BCS Game Setup"
{
    Caption = 'BCS Game Setup';
    PageType = Card;
    SourceTable = "BCS Game Setup";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Game Date"; "Game Date")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Game Date field';
                }
                field("Game Active"; "Game Active")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Game Active field';
                }
                field("Starting Cash"; "Starting Cash")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Starting Cash field';
                }
                field("Starting Basic Locations"; "Starting Basic Locations")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Starting Basic Locations field';
                }
                field("System Unit of Measure"; "System Unit of Measure")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the System Unit of Measure field';
                }

            }
            group(Market)
            {
                Caption = 'Market Adjustments';

                field("Market Move Multiplier"; "Market Move Multiplier")
                {
                    ApplicationArea = All;
                     ToolTip='Specifies the value of the Market Move Multiplier field';
                }
                field("Market Movement Floor"; "Market Movement Floor")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Market Movement Floor field';
                }
            }
            group(GeneralLedger)
            {
                Caption = 'General Ledger';
                field("Wealth Account"; "Wealth Account")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Wealth Account field';
                }

                field("Cash Account"; "Cash Account")
                {
                    ApplicationArea = All;
                     ToolTip='Specifies the value of the Cash Account field';
                }
                field("Starting Balance Account"; "Starting Balance Account")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Starting Balance Account field';
                }
                field("Bot Power Account"; "Bot Power Account")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Bot Power Account field';
                }
                field("Loc. Power Account"; "Loc. Power Account")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Loc. Power Account field';
                }
                field("Inventory Account"; "Inventory Account")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Inventory Account field';
                }
                field("FA Value Account Bot"; "FA Value Account Bot")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the FA Value Account Bot field';
                }
                field("FA Value Account Location"; "FA Value Account Location")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the FA Value Account Location field';
                }

            }

            group(Purchasing)
            {
                field("Purchase Prospect Effort"; "Purchase Prospect Effort")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Purchase Prospect Effort field';
                }
                field("Purch. Pros. Tier Multiplier"; "Purch. Pros. Tier Multiplier")
                {
                    ApplicationArea = All;
                    Caption = 'Pros. Tier Multiplier';
                    ToolTip='Specifies the value of the Pros. Tier Multiplier field';
                }

                field("Purch. Pros. Base Max Orders"; "Purch. Pros. Base Max Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Pros. Base Max Orders';
                     ToolTip='Specifies the value of the Pros. Base Max Orders field';
                }
                field("Purch. Pros. Base Max Quantity"; "Purch. Pros. Base Max Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Pros. Base Max Quantity';
                    ToolTip='Specifies the value of the Pros. Base Max Quantity field';
                }
                field("Vendor Bus. Posting Group"; "Vendor Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Vendor. Bus. Posting Group field';
                }
                field("Vendor Payment Method Code"; "Vendor Payment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Vend. Payment Method Code field';
                }
                field("Vendor Posting Group"; "Vendor Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Vendor Posting Group field';
                }
            }
            group(Sales)
            {
                field("Sales Prospect Effort"; "Sales Prospect Effort")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Sales Prospect Effort field';
                }
                field("Sales. Pros. Tier Multiplier"; "Sales Pros. Tier Multiplier")
                {
                    ApplicationArea = All;
                    Caption = 'Pros. Tier Multiplier';
                    ToolTip='Specifies the value of the Pros. Tier Multiplier field';
                }

                field("Sales. Pros. Base Max Orders"; "Sales Pros. Base Max Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Pros. Base Max Orders';
                     ToolTip='Specifies the value of the Pros. Base Max Orders field';
                }
                field("Sales. Pros. Base Max Quantity"; "Sales Pros. Base Max Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Pros. Base Max Quantity';
                    ToolTip='Specifies the value of the Pros. Base Max Quantity field';
                }
                field("Customer Bus. Posting Group"; "Customer Bus. Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Customer. Bus. Posting Group field';
                }
                field("Customer Payment Method Code"; "Customer Payment Method Code")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Cust. Payment Method Code field';
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Customer Posting Group field';
                }

            }
            group(Location)
            {
                Caption = 'Location';
                field("Location No. Series"; "Location No. Series")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Location No. Series field';
                }
                field("Basic Location Price"; "Basic Location Price")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Basic Location Price field';
                }
                field("Basic Loc. Max. Bots"; "Basic Loc. Max. Bots")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Basic - Maximum Bots field';
                }
                field("Basic Loc. Max. Units"; "Basic Loc. Max. Units")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Basic - Maximum Units field';
                }
                field("Adv. Location Price"; "Adv. Location Price")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Adv. Location Price field';
                }
                field("Adv. Loc. Max. Bots"; "Adv. Loc. Max. Bots")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Adv - Maximum Bots field';
                }
                field("Adv. Loc. Max. Units"; "Adv. Loc. Max. Units")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Adv - Maximum Units field';
                }
                field("Inventory Posting Group"; "Inventory Posting Group")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Inventory Posting Group field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(TickGameDay)
            {
                Image = CalculateCalendar;
                PromotedIsBig = true;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip='Executes the TickGameDay action';

                trigger OnAction()
                begin
                    Rec.Validate("Game Date", CalcDate('<1D>', Rec."Game Date"));
                    Rec.Modify(true);
                end;
            }
            action(CalcMarket)
            {
                Image = AdjustExchangeRates;
                PromotedIsBig = true;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip='Executes the CalcMarket action';

                trigger OnAction()
                var
                    MarketCalc: Codeunit "BCS Market Calculation";
                begin
                    MarketCalc.CalculateDailyPrices();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Reset();
        If not Get() then begin
            Init();
            Insert();
        end;
    end;
}
