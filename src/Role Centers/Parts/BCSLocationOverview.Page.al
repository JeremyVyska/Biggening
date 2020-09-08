page 88030 "BCS Location Overview"
{
    Caption = 'BCS Location Overview';
    PageType = ListPart;
    SourceTable = Location;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field("Total Stock"; "Total Stock")
                {
                    ApplicationArea = All;
                }
                field("Maximum Units"; "Maximum Units")
                {
                    ApplicationArea = All;
                }
                field("Assigned Bots"; "Assigned Bots")
                {
                    ApplicationArea = All;
                }
                field("Maximum Bots"; "Maximum Bots")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

}
