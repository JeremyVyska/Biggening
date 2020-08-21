pageextension 88008 "BCS Customer List" extends "Customer List"
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

        //TODO: North American Specific
        modify("CFDI Purpose")
        {
            Visible = false;
        }
        modify("CFDI Relation")
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

        addfirst(factboxes)
        {
            part(Interests; "BCS Customer Interests")
            {
                Caption = 'Customer Interests';
                SubPageLink = "Customer No." = field("No.");
            }
        }
    }
}