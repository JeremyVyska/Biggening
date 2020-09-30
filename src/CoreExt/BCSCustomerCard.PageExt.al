pageextension 88007 "BCS Customer Card" extends "Customer Card"
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
        modify(Shipping)
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

        addfirst(factboxes)
        {
            part(Interests; "BCS Customer Interests")
            {
                Caption = 'Customer Interests';
                SubPageLink = "Customer No." = field("No.");
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