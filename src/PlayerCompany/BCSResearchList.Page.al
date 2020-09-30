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
                    ToolTip='Specifies the value of the No. field';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Description field';
                }
                field(Selected; Selected)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Selected field';
                }
                field(Points; Points)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Points field';
                }
                field(Progress; Progress)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Progress field';
                }
                field(Completed; Completed)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Completed field';
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
                ToolTip='Executes the Select action';

                trigger OnAction()
                begin
                    Rec.Validate(Selected, true);
                    Rec.Modify(true);
                end;
            }
        }
    }

}
