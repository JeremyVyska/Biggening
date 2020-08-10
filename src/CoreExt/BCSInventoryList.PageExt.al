pageextension 88005 "BCS Inventory List" extends "Location List"
{
    layout
    {
        addafter(Name)
        {
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

    actions
    {
    }
}