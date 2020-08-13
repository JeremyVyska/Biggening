pageextension 88005 "BCS Location List" extends "Location List"
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
        addlast(creation)
        {
            action(PurchaseLocation)
            {
                Caption = 'Buy Location';
                ToolTip = 'Acquire a new Location for Inventory for a price';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = New;
                Image = NewWarehouse;

                trigger OnAction()
                var
                    BCSLocationMgmt: Codeunit "BCS Location Management";
                    WhichLocationQst: Label 'Which type of Location do you wish to buy?';
                    BasicTok: Label 'Basic';
                    AdvTok: Label 'Advanced';
                begin
                    case StrMenu(BasicTok + ',' + AdvTok, 0, WhichLocationQst) of
                        1:
                            BCSLocationMgmt.PurchaseLocation(true);
                        2:
                            BCSLocationMgmt.PurchaseLocation(false);
                    end;
                end;
            }
        }
    }
}