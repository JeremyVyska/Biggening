pageextension 88000 "BCS Company Information" extends "Company Information"
{
    layout
    {
        addlast(General)
        {
            field("Master Company"; "Master Company")
            {
                ApplicationArea = All;
            }
            field("Current Game Date"; "Current Game Date")
            {
                ApplicationArea = All;
            }
        }

    }
}