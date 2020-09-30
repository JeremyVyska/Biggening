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
                      ToolTip='Specifies the value of the Name field';
                }
                field("Upgrade Code"; "Upgrade Code")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Upgrade Code field';
                }
                field("Maximum Bots"; "Maximum Bots")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Maximum Bots field';
                }
                field("Assigned Bots"; "Assigned Bots")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Assigned Bots field';
                }
                field("Maximum Units"; "Maximum Units")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Maximum Units field';
                }
                field("Total Stock"; "Total Stock")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Total Stock field';
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