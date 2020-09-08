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

}
