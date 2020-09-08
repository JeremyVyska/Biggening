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
                }
                field("Error Type"; "Error Type")
                {
                    ApplicationArea = All;
                }
                field(Acknowledged; Acknowledged)
                {
                    ApplicationArea = All;
                }

                field("Company Name"; "Company Name")
                {
                    ApplicationArea = All;
                }
                field("Bot Instance"; "Bot Instance")
                {
                    ApplicationArea = All;
                }
                field("Bot Type"; "Bot Type")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Error Message"; "Error Message")
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
            action(Ack)
            {
                Caption = 'Acknowledge';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Image = Approve;
                Enabled = not Acknowledged;

                trigger OnAction()
                var
                    Selected: Record "BCS Bot Error Log";
                    AckMsg: Label '%1 errors acknowledged.';
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
