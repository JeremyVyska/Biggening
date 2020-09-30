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
                    ToolTip='Specifies the value of the Company Name field';
                }
                field("Contact Name"; "Contact Name")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Contact Name field';
                }
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Entry No. field';
                }
                field(Address; Address)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Address field';
                }
                field(Email; Email)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Email field';
                }
            }
        }
    }

}
