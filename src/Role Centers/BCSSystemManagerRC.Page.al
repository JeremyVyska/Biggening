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

                action("Bot Templates")
                {
                    ToolTip = 'Manage Bot Templates';
                    RunObject = Page "BCS Bot Template List";
                    ApplicationArea = Basic, Suite;

                }

                action("Assisted Setup")
                {
                    ToolTip = 'Set up core functionality such as sales tax, sending documents as email, and approval workflow by running through a few pages that guide you through the information.';
                    RunObject = Page "Assisted Setup";
                    ApplicationArea = Basic, Suite;
                }
            }
        }
    }

}