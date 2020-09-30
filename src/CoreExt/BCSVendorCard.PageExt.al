pageextension 88001 "BCS Vendor Card" extends "Vendor Card"
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
        modify(Invoicing)
        {
            Editable = IsAdmin;
        }
        modify(Payments)
        {
            Editable = IsAdmin;
        }
        modify(Receiving)
        {
            Editable = IsAdmin;
        }

        addafter(General)
        {
            group(PlayerInfo)
            {
                Caption = 'Player Information & Settings';
                field(EditableLocationCode; "Location Code")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Location Code field';
                }
                field(MaxOrdersPerDay; "Max Orders Per Day")
                {
                    ApplicationArea = All;
                    Editable = IsAdmin;
                    ToolTip='Specifies the value of the Max Orders Per Day field';
                }
                field(MaxQtyPerDay; "Max Quantity Per Day")
                {
                    ApplicationArea = All;
                    Editable = IsAdmin;
                    ToolTip='Specifies the value of the Max Quantity Per Day field';
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