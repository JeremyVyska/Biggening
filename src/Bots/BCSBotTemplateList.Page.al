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
                    ToolTip='Specifies the value of the Bot Type field';
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Code field';
                }
                field("Bot Tier"; "Bot Tier")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Bot Tier field';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Description field';
                }
                field("Start With"; "Start With")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Start With field';
                }
                field("Base Price"; "Base Price")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Base Price field';
                }
                field(Materials; Materials)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Materials field';
                }
                field("Base Power Per Day"; "Base Power Per Day")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Base Power Per Day field';
                }
                field("Base Operations Per Day"; "Base Operations Per Day")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Base Ops. Per Day field';
                }
                field("Research Points Per Op"; "Research Points Per Op")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Research Points Per Op. field';
                }
                field("Maximum Doc. Lines Per Op"; "Maximum Doc. Lines Per Op")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Maximum Doc. Lines Per Op field';
                }
                field("Marketing Bot Item Tier"; "Marketing Bot Item Tier")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Marketing Bot Item Tier field';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(MaterialsBtn)
            {
                ApplicationArea = All;
                Caption = 'Materials';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = BOMVersions;
                RunObject = Page "BCS Bot Temp. Req. List";
                RunPageMode = Edit;
                RunPageLink = "Bot Template Code" = field(Code);
                ToolTip='Executes the Materials action';
            }
        }
    }
}
