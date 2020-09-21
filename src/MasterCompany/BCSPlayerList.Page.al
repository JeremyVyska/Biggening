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
                }
                field("Name"; "Name")
                {
                    ApplicationArea = All;
                }
                field("System Permissions"; "System Permissions")
                {
                    ApplicationArea = All;
                }

                field("Email"; "Email")
                {
                    ApplicationArea = All;
                }
                field("Company Name"; "Company Name")
                {
                    ApplicationArea = All;
                }
                field("Company Display Name"; "Company Display Name")
                {
                    ApplicationArea = All;
                }
                field("User Name"; "User Name")
                {
                    ApplicationArea = All;
                }
                field("Step - Company Made"; "Step - Company Made")
                {
                    ApplicationArea = All;
                }
                field("Step - User Made"; "Step - User Made")
                {
                    ApplicationArea = All;
                }
                field("Step - Master Data Copy"; "Step - Master Data Copy")
                {
                    ApplicationArea = All;
                }
                field("Step - Job Queues Made"; "Step - Job Queues Made")
                {
                    ApplicationArea = All;
                }
                field("Step - Init. Job Ran"; "Step - Init. Job Ran")
                {
                    ApplicationArea = All;
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
