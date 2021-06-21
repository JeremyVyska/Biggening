page 88050 "BCS System Manager RC"
{
    PageType = RoleCenter;
    Caption = 'BC System Manager';

    layout
    {
        area(RoleCenter)
        {
            /* part(Activities; "AppName Activities")
            {
                ApplicationArea = Basic, Suite;
            } */

            part(PlayerOverview; BCSPlayerOverview)
            {
                ApplicationArea = All;
            }
            part(JobQueueOverview; "BCS Job Queue Overview")
            {
                ApplicationArea = All;
            }
            part(MarketOverview; "BCS Market Overview")
            {
                ApplicationArea = All;
            }
            part(SetupOverview; "BCS Setup Overview")
            {
                ApplicationArea = Basic, Suite;
            }
        }
    }

    actions
    {

        area(Sections)
        {
            group(Setup)
            {
                Caption = 'Setup';
                ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Image = Setup;
                action("Game Setup")
                {
                    ToolTip = 'Biggening Game Setup';
                    RunObject = Page "BCS Game Setup";
                    ApplicationArea = All;
                }
                action("Master Tables")
                {
                    ToolTip = 'master tables are teh setup tables to include when populating the Player companies';
                    RunObject = Page "BCS Master Table Checklist";
                    ApplicationArea = All;
                }
                action("Bot Templates")
                {
                    ToolTip = 'Manage Bot Templates';
                    RunObject = Page "BCS Bot Template List";
                    ApplicationArea = Basic, Suite;

                }
                action("Master Items")
                {
                    ToolTip = 'Manage Master Items for the game';
                    RunObject = Page "BCS Master Item List";
                    ApplicationArea = All;
                }
                action("Seasons")
                {
                    ToolTip = 'Manage the Seasons';
                    RunObject = Page "BCS Season List";
                    ApplicationArea = All;
                }
                action("Players")
                {
                    ToolTip = 'Manage the Players';
                    RunObject = Page "BCS Player List";
                    ApplicationArea = All;
                }
                action("Random Name Pools")
                {
                    ToolTip = 'Manage the Random names drawn from for Customer and Vendor prospects';
                    RunObject = Page "BCS Random Entity Name Pool";
                    ApplicationArea = All;
                }
            }
            group("Current Season")
            {
                Caption = 'Current Season';
                ToolTip = 'Information and Settings for the Currently Active Season';

                action("Snaphots")
                {
                    ToolTip = 'Snapshot List';
                    RunObject = page "BCS Snapshot List";
                    ApplicationArea = All;
                }
                action("Market Prices")
                {
                    ToolTip = 'Current market prices of items';
                    RunObject = page "BCS Market Price";
                    ApplicationArea = All;
                }
                action("Market Trades")
                {
                    ToolTip = 'Overview of trading volume of items';
                    RunObject = page "BCS Market Trades";
                    ApplicationArea = All;
                }
            }

        }
        area(Embedding)
        {
            action(GameSetupEmbed)
            {
                ToolTip = 'Biggening Game Setup';
                RunObject = Page "BCS Game Setup";
                ApplicationArea = All;
            }
            action("SeasonsEmbed")
            {
                ToolTip = 'Manage the Seasons';
                RunObject = Page "BCS Season List";
                ApplicationArea = All;
            }
            action("PlayersEmbed")
            {
                ToolTip = 'Manage the Players';
                RunObject = Page "BCS Player List";
                ApplicationArea = All;
            }
        }
    }

}