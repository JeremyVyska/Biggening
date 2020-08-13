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
                field("Purchase Prospect Effort"; "Purchase Prospect Effort")
                {
                    ApplicationArea = All;
                }
                field("Purch. Pros. Tier Multiplier"; "Purch. Pros. Tier Multiplier")
                {
                    ApplicationArea = All;
                }

                field("Purch. Pros. Base Max Orders"; "Purch. Pros. Base Max Orders")
                {
                    ApplicationArea = All;
                }
                field("Purch. Pros. Base Max Quantity"; "Purch. Pros. Base Max Quantity")
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
