page 88020 "BCS Season List"
{
    ApplicationArea = All;
    Caption = 'BCS Season List';
    PageType = List;
    SourceTable = "BCS Season";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Built On Version"; "Built On Version")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Active; Active)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Participants; Participants)
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
            action(CreateSeason)
            {
                Image = NewBranch;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    SeasonNewCreate: Codeunit "BCS Season Create";
                begin
                    SeasonNewCreate.CreateNewSeason();
                end;
            }
        }
    }
}
