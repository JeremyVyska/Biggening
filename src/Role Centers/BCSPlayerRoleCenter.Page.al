page 88004 "BCS Player Role Center"
{
    Caption = 'BCS Player Role Center';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            part(PlayerActivities; "BCS Player Activities")
            {
                ApplicationArea = All;
            }
            part(BCSLocationOverview; "BCS Location Overview")
            {
                ApplicationArea = All;
            }
            part(BCSItemOverview; "BCS Item Overview")
            {
                ApplicationArea = all;
            }
            part(BotTypeOverview; "BCS Bot Type Overview")
            {
                ApplicationArea = All;
            }
            part(StandingOverview; "BCS Standings Overview")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Sections)
        {
            group(Operations)
            {
                Caption = 'Operation';
                action(Bots)
                {
                    Caption = 'Bots';
                    Image = SetupLines;
                    RunObject = Page "BCS Bot Instance List";
                    ToolTip = 'Executes the Bots action';
                }
                action(ItemList)
                {
                    ApplicationArea = All;
                    Caption = 'Items';
                    Image = Item;
                    RunObject = Page "Item List";
                    ToolTip = 'Executes the Items action';
                }
                action(LocationList)
                {
                    ApplicationArea = All;
                    Caption = 'Locations';
                    Image = CreateWhseLoc;
                    RunObject = Page "Location List";
                    ToolTip = 'Opens the Location List';
                }
                action(ProspectList)
                {
                    ApplicationArea = All;
                    Image = ContactFilter;
                    RunObject = page "BCS Prospect List";
                }

            }
            group(Information)
            {
                Caption = 'Information';
                action(ChartofAcc)
                {
                    ApplicationArea = All;
                    Caption = 'Chart of Accounts', comment = 'NLB="YourLanguageCaption"';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = ChartOfAccounts;
                    RunObject = Page "Chart of Accounts";
                    ToolTip = 'Executes the Chart of Accounts';
                }
                action(PowerUsage)
                {
                    ApplicationArea = All;
                    Image = CreateRating;
                    RunObject = Page "BCS Power Usage Ledger";
                }
                action(ResearchList)
                {
                    ApplicationArea = All;
                    Image = BOMLedger;
                    RunObject = page "BCS Research List";
                }
                action(ActivitiesLog)
                {
                    ApplicationArea = All;
                    Image = CoupledOpportunitiesList;
                    RunObject = page "BCS Bot Activity Log";
                }

            }
        }

        area(Embedding)
        {
            action(BotList)
            {
                Caption = 'Bots';
                Image = SetupLines;
                RunObject = Page "BCS Bot Instance List";
                ToolTip = 'Executes the Bots action';
            }
            action(Items)
            {
                ApplicationArea = All;
                Caption = 'Items';
                Image = Item;
                RunObject = Page "Item List";
                ToolTip = 'Executes the Items action';
            }
        }

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
                RunObject = Codeunit "BCS Bot Purchase";
                ToolTip = 'Executes the Buy Bot action';
            }
        }
    }
}
