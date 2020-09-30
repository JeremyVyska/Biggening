page 88019 "BCS Player List"
{

    ApplicationArea = All;
    Caption = 'BCS Player List';
    PageType = List;
    SourceTable = "BCS Player";
    UsageCategory = Lists;

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
                field("Name"; "Name")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Name field';
                }
                field("System Permissions"; "System Permissions")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the System Permissions field';
                }

                field("Email"; "Email")
                {
                    ApplicationArea = All;
                     ToolTip='Specifies the value of the Email field';
                }
                field("Company Name"; "Company Name")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Company Name field';
                }
                field("Company Display Name"; "Company Display Name")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Company Display Name field';
                }
                field("User Name"; "User Name")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the User Name field';
                }
                field("Step - Company Made"; "Step - Company Made")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Company Made field';
                }
                field("Step - User Made"; "Step - User Made")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the User Made field';
                }
                field("Step - Master Data Copy"; "Step - Master Data Copy")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Master Data Copied field';
                }
                field("Step - Job Queues Made"; "Step - Job Queues Made")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Job Queues Made field';
                }
                field("Step - Init. Job Ran"; "Step - Init. Job Ran")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Init. Job Ran field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Generate)
            {
                Caption = 'Setup New Player';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip='Executes the Setup New Player action';

                trigger OnAction()
                var
                    BCSPlayerMgmt: Codeunit "BCS Player Management";
                begin
                    BCSPlayerMgmt.SetupNewPlayer(Rec);
                    CurrPage.Update();
                end;
            }
            action(Restart)
            {
                Caption = 'Restart Player';
                Image = Setup;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip='Executes the Restart Player action';

                trigger OnAction()
                var
                    BCSPlayerMgmt: Codeunit "BCS Player Management";
                begin
                    BCSPlayerMgmt.RemovePlayerCompany(Rec);
                    CurrPage.Update();
                end;
            }
        }
    }

}
