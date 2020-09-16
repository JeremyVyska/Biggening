pageextension 88006 "BCS Location Card" extends "Location Card"
{
    layout
    {
        modify(General)
        {
            Editable = IsAdmin;
        }
        modify("Address & Contact")
        {
            Editable = IsAdmin;
        }
        modify(Warehouse)
        {
            Editable = IsAdmin;
        }
        modify(Bins)
        {
            Editable = IsAdmin;
        }
        modify("Bin Policies")
        {
            Editable = IsAdmin;
        }
        addafter(General)
        {
            group(PlayerInfo)
            {
                Caption = 'Player Information';

                field(PlayerLocName; Name)
                {
                    ApplicationArea = All;
                }
                field("Upgrade Code"; "Upgrade Code")
                {
                    ApplicationArea = All;
                }
                field("Maximum Bots"; "Maximum Bots")
                {
                    ApplicationArea = All;
                }
                field("Assigned Bots"; "Assigned Bots")
                {
                    ApplicationArea = All;
                }
                field("Maximum Units"; "Maximum Units")
                {
                    ApplicationArea = All;
                }
                field("Total Stock"; "Total Stock")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        IsAdmin := PlayerMgmt.SetIsAdmin();
    end;

    var
        PlayerMgmt: Codeunit "BCS Player Management";
        IsAdmin: Boolean;
}