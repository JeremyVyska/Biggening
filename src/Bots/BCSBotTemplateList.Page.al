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
            }
        }
    }

}
