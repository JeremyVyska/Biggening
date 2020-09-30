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
                    ToolTip='Specifies the value of the No. field';
                }
                field("Research Type"; "Research Type")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Research Type field';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Description field';
                }
                field("Unmet Hide"; "Unmet Hide")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Unmet Hide field';
                }
                field(Points; Points)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Points field';
                }
                field("Required By"; "Required By")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Required By field';
                }
                field(Prerequisites; Prerequisites)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Prerequisites field';
                }
                field("Has Research Req."; "Has Research Req.")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Has Research Req. field';
                }
                field("Operation Bonus Type"; "Operation Bonus Type")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Operations;
                    ToolTip='Specifies the value of the Operation Bonus Type field';
                }
                field("Operations Per Day Bonus"; "Operations Per Day Bonus")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Operations;
                    ToolTip='Specifies the value of the Operations Per Day Bonus field';
                }
                field("Operation Bonus Code"; "Operation Bonus Code")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Operations;
                    ToolTip='Specifies the value of the Operation Bonus Code field';
                }
                field("Power Bonus Type"; "Power Bonus Type")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Power;
                    ToolTip='Specifies the value of the Power Bonus Type field';
                }
                field("Power Per Day Bonus"; "Power Per Day Bonus")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Power;
                    ToolTip='Specifies the value of the Power Per Day Bonus field';
                }
                field("Power Bonus Code"; "Power Bonus Code")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Power;
                    ToolTip='Specifies the value of the Power Bonus Code field';
                }
                field("Prospect Maximum Multiplier"; "Prospect Maximum Multiplier")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::Prospects;
                    ToolTip='Specifies the value of the Prospect Maximum Multiplier field';
                }
                field("Item Category Code"; "Item Category Code")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::"Unlock-ItemCC";
                    ToolTip='Specifies the value of the Item Category Code field';
                }
                field("Product Posting Group"; "Product Posting Group")
                {
                    ApplicationArea = All;
                    Editable = "Research Type" = "Research Type"::"Unlock-ProdPG";
                    ToolTip='Specifies the value of the Product Posting Group field';
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
