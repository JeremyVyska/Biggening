pageextension 88000 "BCS Company Information" extends "Company Information"
{
    layout
    {
        addlast(General)
        {
            field("Master Company"; "Master Company")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Master Company field';
            }
            field("Current Game Date"; "Current Game Date")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Current Game Date field';
            }
        }

    }

    actions
    {
        addlast(Processing)
        {
            action(Initialize)
            {
                Caption = 'Initialize';
                ToolTip = 'Init the Company';
                trigger OnAction()
                var
                    StartingValues: Codeunit "BCS Player Starting Values";
                begin
                    StartingValues.Run();
                end;
            }
        }
    }
}