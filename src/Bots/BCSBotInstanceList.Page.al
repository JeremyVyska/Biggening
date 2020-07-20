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
                }
                field("Bot Type"; "Bot Type")
                {
                    ApplicationArea = All;
                }
                field(Designation; Designation)
                {
                    ApplicationArea = All;
                }
                field("Bot Name"; "Bot Name")
                {
                    ApplicationArea = All;
                }
                field("Power Per Day"; "Power Per Day")
                {
                    ApplicationArea = All;
                }
                field("Operations Per Day"; "Operations Per Day")
                {
                    ApplicationArea = All;
                }
                field("Assignment Code"; "Assignment Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Operations Update Code"; "Operations Update Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Power Upgrade Code"; "Power Upgrade Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Price; Price)
                {
                    ApplicationArea = All;
                    Visible = false;
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
                ApplicationArea = All;

                trigger OnAction()
                begin
                    Page.RunModal(Page::"BCS Bot Purchase");
                end;
            }
        }
    }

}
