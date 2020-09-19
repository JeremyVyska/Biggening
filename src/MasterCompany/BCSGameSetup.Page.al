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
                }
                field("Game Active"; "Game Active")
                {
                    ApplicationArea = All;
                }
                field("Starting Cash"; "Starting Cash")
                {
                    ApplicationArea = All;
                }
                field("Starting Basic Locations"; "Starting Basic Locations")
                {
                    ApplicationArea = All;
                }
                field("System Unit of Measure"; "System Unit of Measure")
                {
                    ApplicationArea = All;
                }

            }
            group(Market)
            {
                Caption = 'Market Adjustments';

                field("Market Move Multiplier"; "Market Move Multiplier")
                {
                    ApplicationArea = All;
                }
                field("Market Movement Floor"; "Market Movement Floor")
                {
                    ApplicationArea = All;
                }
            }
            group(GeneralLedger)
            {
                Caption = 'General Ledger';
                field("Wealth Account"; "Wealth Account")
                {
                    ApplicationArea = All;
                }

                field("Cash Account"; "Cash Account")
                {
                    ApplicationArea = All;
                }
                field("Starting Balance Account"; "Starting Balance Account")
                {
                    ApplicationArea = All;
                }
                field("Bot Power Account"; "Bot Power Account")
                {
                    ApplicationArea = All;
                }
                field("Loc. Power Account"; "Loc. Power Account")
                {
                    ApplicationArea = All;
                }
                field("Inventory Account"; "Inventory Account")
                {
                    ApplicationArea = All;
                }
                field("FA Value Account Bot"; "FA Value Account Bot")
                {
                    ApplicationArea = All;
                }
                field("FA Value Account Location"; "FA Value Account Location")
                {
                    ApplicationArea = All;
                }

            }

            group(Purchasing)
            {
                field("Purchase Prospect Effort"; "Purchase Prospect Effort")
                {
                    ApplicationArea = All;
                }
                field("Purch. Pros. Tier Multiplier"; "Purch. Pros. Tier Multiplier")
                {
                    ApplicationArea = All;
                    Caption = 'Pros. Tier Multiplier';
                }

                field("Purch. Pros. Base Max Orders"; "Purch. Pros. Base Max Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Pros. Base Max Orders';
                }
                field("Purch. Pros. Base Max Quantity"; "Purch. Pros. Base Max Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Pros. Base Max Quantity';
                }
                field("Vendor Bus. Posting Group"; "Vendor Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Vendor Payment Method Code"; "Vendor Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Vendor Posting Group"; "Vendor Posting Group")
                {
                    ApplicationArea = All;
                }
            }
            group(Sales)
            {
                field("Sales Prospect Effort"; "Sales Prospect Effort")
                {
                    ApplicationArea = All;
                }
                field("Sales. Pros. Tier Multiplier"; "Sales Pros. Tier Multiplier")
                {
                    ApplicationArea = All;
                    Caption = 'Pros. Tier Multiplier';
                }

                field("Sales. Pros. Base Max Orders"; "Sales Pros. Base Max Orders")
                {
                    ApplicationArea = All;
                    Caption = 'Pros. Base Max Orders';
                }
                field("Sales. Pros. Base Max Quantity"; "Sales Pros. Base Max Quantity")
                {
                    ApplicationArea = All;
                    Caption = 'Pros. Base Max Quantity';
                }
                field("Customer Bus. Posting Group"; "Customer Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Customer Payment Method Code"; "Customer Payment Method Code")
                {
                    ApplicationArea = All;
                }
                field("Customer Posting Group"; "Customer Posting Group")
                {
                    ApplicationArea = All;
                }

            }
            group(Location)
            {
                Caption = 'Location';
                field("Location No. Series"; "Location No. Series")
                {
                    ApplicationArea = All;
                }
                field("Basic Location Price"; "Basic Location Price")
                {
                    ApplicationArea = All;
                }
                field("Basic Loc. Max. Bots"; "Basic Loc. Max. Bots")
                {
                    ApplicationArea = All;
                }
                field("Basic Loc. Max. Units"; "Basic Loc. Max. Units")
                {
                    ApplicationArea = All;
                }
                field("Adv. Location Price"; "Adv. Location Price")
                {
                    ApplicationArea = All;
                }
                field("Adv. Loc. Max. Bots"; "Adv. Loc. Max. Bots")
                {
                    ApplicationArea = All;
                }
                field("Adv. Loc. Max. Units"; "Adv. Loc. Max. Units")
                {
                    ApplicationArea = All;
                }
                field("Inventory Posting Group"; "Inventory Posting Group")
                {
                    ApplicationArea = All;
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
