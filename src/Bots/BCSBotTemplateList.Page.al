page 88000 "BCS Bot Template List"
{
    ApplicationArea = All;
    Caption = 'Bot Template List';
    AdditionalSearchTerms = 'bots';
    PageType = List;
    SourceTable = "BCS Bot Template";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bot Type"; "Bot Type")
                {
                    ApplicationArea = All;
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Base Price"; "Base Price")
                {
                    ApplicationArea = All;
                }
                field("Base Power Per Day"; "Base Power Per Day")
                {
                    ApplicationArea = All;
                }
                field("Base Operations Per Day"; "Base Operations Per Day")
                {
                    ApplicationArea = All;
                }
                field("Research Points Per Op"; "Research Points Per Op")
                {
                    ApplicationArea = All;
                }
                field("Maximum Doc. Lines Per Op"; "Maximum Doc. Lines Per Op")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
