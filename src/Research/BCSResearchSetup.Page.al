page 88011 "BCS Research Setup"
{
    ApplicationArea = All;
    Caption = 'BCS Research Setup';
    PageType = List;
    SourceTable = "BCS Research";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Research Type"; "Research Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Unmet Hide"; "Unmet Hide")
                {
                    ApplicationArea = All;
                }
                field(Points; Points)
                {
                    ApplicationArea = All;
                }
                field("Required By"; "Required By")
                {
                    ApplicationArea = All;
                }
                field(Prerequisites; Prerequisites)
                {
                    ApplicationArea = All;
                }
                field("Has Research Req."; "Has Research Req.")
                {
                    ApplicationArea = All;
                }
                field("Operation Bonus Type"; "Operation Bonus Type")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Operations;
                }
                field("Operations Per Day Bonus"; "Operations Per Day Bonus")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Operations;
                }
                field("Operation Bonus Code"; "Operation Bonus Code")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Operations;
                }
                field("Power Bonus Type"; "Power Bonus Type")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Power;
                }
                field("Power Per Day Bonus"; "Power Per Day Bonus")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Power;
                }
                field("Power Bonus Code"; "Power Bonus Code")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Power;
                }
                field("Prospect Maximum Multiplier"; "Prospect Maximum Multiplier")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Prospects;
                }
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::"Unlock-ItemCC";
                }
                field("Product Posting Group"; "Product Posting Group")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::"Unlock-ProdPG";
                }
            }

            part(Prereq; "BCS Research Subpage")
            {
                SubPageLink = "Research No." = field("No.");
                UpdatePropagation = Both;
            }
        }
    }

}
