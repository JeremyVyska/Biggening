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
                    ToolTip='Specifies the value of the Built On Version field';
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the No. field';
                }
                field(Active; Active)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Active field';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Description field';
                }
                field(Participants; Participants)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Participants field';
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
                ToolTip='Executes the CreateSeason action';

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
