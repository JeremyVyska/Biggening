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
                    ToolTip='Specifies the value of the Code field';
                }
                field(Name; Name)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Name field';
                }
                field("Total Stock"; "Total Stock")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Total Stock field';
                }
                field("Maximum Units"; "Maximum Units")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Maximum Units field';
                }
                field("Assigned Bots"; "Assigned Bots")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Assigned Bots field';
                }
                field("Maximum Bots"; "Maximum Bots")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Maximum Bots field';
                }
            }
        }
    }

}
