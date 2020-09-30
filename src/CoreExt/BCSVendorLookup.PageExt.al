pageextension 88003 "BCS Vendor Lookup" extends "Vendor Lookup"
{
    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Phone No.")
        {
            Visible = false;
        }
        modify(Contact)
        {
            Visible = false;
        }
        modify("Search Name")
        {
            Visible = false;
        }
        modify(City)
        {
            Visible = false;
        }
        modify("Post Code")
        {
            Visible = false;
        }

        addafter(Name)
        {
            field("Max Orders Per Day"; "Max Orders Per Day")
            {
                ApplicationArea = all;
                ToolTip='Specifies the value of the Max Orders Per Day field';
            }
            field("Max Quantity Per Day"; "Max Quantity Per Day")
            {
                ApplicationArea = all;
                ToolTip='Specifies the value of the Max Quantity Per Day field';
            }
        }
    }

}