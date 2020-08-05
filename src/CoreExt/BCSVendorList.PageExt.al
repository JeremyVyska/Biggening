pageextension 88002 "BCS Vendor List" extends "Vendor List"
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
        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Payments (LCY)")
        {
            Visible = false;
        }

        addafter(Name)
        {
            field("Max Orders Per Day"; "Max Orders Per Day")
            {
                ApplicationArea = all;
            }
            field("Max Quantity Per Day"; "Max Quantity Per Day")
            {
                ApplicationArea = all;
            }
        }
    }

}