page 88018 "BCS Research List"
{
    ApplicationArea = All;
    Caption = 'BCS Research List';
    PageType = List;
    SourceTable = "BCS Research Progress";
    UsageCategory = Lists;
    Editable = false;

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
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Selected; Selected)
                {
                    ApplicationArea = All;
                }
                field(Points; Points)
                {
                    ApplicationArea = All;
                }
                field(Progress; Progress)
                {
                    ApplicationArea = All;
                }
                field(Completed; Completed)
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
            action(Select)
            {
                Image = Approval;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Caption = 'Select';

                trigger OnAction()
                begin
                    Rec.Validate(Selected, true);
                    Rec.Modify(true);
                end;
            }
        }
    }

}
