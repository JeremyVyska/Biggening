pageextension 88005 "BCS Location List" extends "Location List"
{
    layout
    {
        addafter(Name)
        {
            field("Upgrade Code"; "Upgrade Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Upgrade Code field';
            }
            field("Maximum Bots"; "Maximum Bots")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Maximum Bots field';
            }
            field("Assigned Bots"; "Assigned Bots")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Assigned Bots field';
            }
            field("Maximum Units"; "Maximum Units")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Maximum Units field';
            }
            field("Total Stock"; "Total Stock")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Total Stock field';
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
                    Location: Record Location;
                    GameSetup: Record "BCS Game Setup";
                    BCSLocationMgmt: Codeunit "BCS Location Management";
                    LocationCard: Page "Location Card";
                    NewLocationCode: Code[20];
                    WhichLocationQst: Label 'Which type of Location do you wish to buy?';
                    BasicTok: Label 'Basic (Price: %1)', Comment = '%1 is the price of a Basic Location';
                    AdvTok: Label 'Advanced (Price: %1)', Comment = '%1 is the price of a Advanced Location';
                begin
                    GameSetup.Get();
                    case StrMenu(StrSubstNo(BasicTok, GameSetup."Basic Location Price") + ','
                       + StrSubstNo(AdvTok, GameSetup."Adv. Location Price"), 0, WhichLocationQst) of
                        1:
                            NewLocationCode := BCSLocationMgmt.PurchaseLocation(true);
                        2:
                            NewLocationCode := BCSLocationMgmt.PurchaseLocation(false);
                    end;
                    if NewLocationCode <> '' then begin
                        Location.get(NewLocationCode);
                        LocationCard.SetRecord(Location);
                        LocationCard.Run();
                    end;
                end;
            }
        }
    }
}