page 88010 "BCS Bot Error Log"
{

    ApplicationArea = All;
    Caption = 'BCS Bot Error Log';
    PageType = List;
    SourceTable = "BCS Bot Error Log";
    UsageCategory = History;
    Editable = false;
    Permissions = tabledata "BCS Bot Error Log" = m;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Entry No. field';
                }
                field("Error Type"; "Error Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Error Type field';
                }
                field(Acknowledged; Acknowledged)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Acknowledged field';
                }

                field("Company Name"; "Company Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Company Name field';
                }
                field("Bot Instance"; "Bot Instance")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bot Instance field';
                }
                field("Bot Type"; "Bot Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Bot Type field';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Posting Date field';
                }
                field("Error Message"; "Error Message")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Error Message field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Ack)
            {
                Caption = 'Acknowledge';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Approve;
                Enabled = not Acknowledged;
                ToolTip = 'Executes the Acknowledge action';

                trigger OnAction()
                var
                    Selected: Record "BCS Bot Error Log";
                    AckMsg: Label '%1 errors acknowledged.', Comment = '%1 is how many errors the user acknowledged.';
                begin
                    CurrPage.SetSelectionFilter(Selected);
                    if Selected.Count = 1 then begin
                        Rec.Acknowledged := true;
                        Rec.Modify(true);
                    end else begin
                        Selected.ModifyAll(Acknowledged, true, true);
                        Selected.SetRange(Acknowledged);
                        Message(AckMsg, Selected.Count);
                    end;
                end;
            }
        }
    }

    trigger OnOpenPage()
    var
        PlayerMgmt: Codeunit "BCS Player Management";
        IsAdmin: Boolean;
    begin
        IsAdmin := PlayerMgmt.SetIsAdmin();
        if not IsAdmin then begin
            FilterGroup(10);
            SetRange("Error Type", "Error Type"::PlayerError);
            FilterGroup(0);
        end;

    end;
}
