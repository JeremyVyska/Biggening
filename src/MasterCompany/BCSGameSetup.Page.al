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
            }
            group(Purchasing)
            {
                field("Purchase Prospect Effort"; "Sales Prospect Effort")
                {
                    ApplicationArea = All;
                }
                field("Purch. Pros. Tier Multiplier"; "Sales Pros. Tier Multiplier")
                {
                    ApplicationArea = All;
                }

                field("Purch. Pros. Base Max Orders"; "Sales Pros. Base Max Orders")
                {
                    ApplicationArea = All;
                }
                field("Purch. Pros. Base Max Quantity"; "Sales Pros. Base Max Quantity")
                {
                    ApplicationArea = All;
                }
            }
            group(Salesasing)
            {
                field("Salesase Prospect Effort"; "Sales Prospect Effort")
                {
                    ApplicationArea = All;
                }
                field("Sales. Pros. Tier Multiplier"; "Sales Pros. Tier Multiplier")
                {
                    ApplicationArea = All;
                }

                field("Sales. Pros. Base Max Orders"; "Sales Pros. Base Max Orders")
                {
                    ApplicationArea = All;
                }
                field("Sales. Pros. Base Max Quantity"; "Sales Pros. Base Max Quantity")
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
                field("Basic Loc. Max. Bots"; "Basic Loc. Max. Bots")
                {
                    ApplicationArea = All;
                }
                field("Basic Loc. Max. Units"; "Basic Loc. Max. Units")
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
