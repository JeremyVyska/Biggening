page 88002 "BCS Bot Instance List"
{

    ApplicationArea = All;
    Caption = 'Bot List';
    AdditionalSearchTerms = 'bots';
    PageType = List;
    SourceTable = "BCS Bot Instance";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Instance ID"; "Instance ID")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Instance ID field';
                }
                field("Bot Type"; "Bot Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bot Type field';
                }
                field(Designation; Designation)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Designation field';
                }
                field("Bot Name"; "Bot Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bot Name field';
                }
                field("Assignment Code"; "Assignment Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Assignment Code field';
                }
                field("Power Per Day"; "Power Per Day")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Power Per Day field';
                }
                field("Operations Per Day"; "Operations Per Day")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Ops. Per Day field';
                }
                field("Operations Upgrade Code"; "Operations Upgrade Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Operations Upgrade Code field';
                }
                field("Power Upgrade Code"; "Power Upgrade Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Power Upgrade Code field';
                }
                field(Price; Price)
                {
                    ApplicationArea = All;
                    Visible = false;
                    ToolTip = 'Specifies the value of the Price field';
                }
                field("Research Points Per Op"; "Research Points Per Op")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Research Points Per Op. field';
                }
                field("Maximum Doc. Lines Per Op"; "Maximum Doc. Lines Per Op")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximum Doc. Lines Per Op field';
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(AddBot)
            {
                Image = New;
                Caption = 'Buy Bot';
                Promoted = true;
                PromotedCategory = New;
                PromotedIsBig = true;
                ApplicationArea = All;
                ToolTip = 'Executes the Buy Bot action';

                trigger OnAction()
                begin
                    Page.RunModal(Page::"BCS Bot Purchase Wizard");
                end;
            }
        }
        area(Navigation)
        {
            action(PowerEntries)
            {
                Image = LedgerEntries;
                Caption = 'Power Usage';
                ApplicationArea = All;
                RunObject = Page "BCS Power Usage Ledger";
                RunPageLink = "Bot Instance" = field("Instance ID");
                ToolTip = 'Executes the Power Usage action';
            }
        }
    }

}
