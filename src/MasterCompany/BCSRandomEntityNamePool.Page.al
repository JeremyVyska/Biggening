page 88006 "BCS Random Entity Name Pool"
{
    ApplicationArea = All;
    Caption = 'BCS Random Entity Name Pool';
    PageType = List;
    SourceTable = "BCS Random Entity Name Pool";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Company Name"; "Company Name")
                {
                    ApplicationArea = All;
                }
                field("Contact Name"; "Contact Name")
                {
                    ApplicationArea = All;
                }
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field(Address; Address)
                {
                    ApplicationArea = All;
                }
                field(Email; Email)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
