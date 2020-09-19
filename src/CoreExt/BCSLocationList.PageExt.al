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
                    Location: Record Location;
                    GameSetup: Record "BCS Game Setup";
                    LocationCard: Page "Location Card";
                    BCSLocationMgmt: Codeunit "BCS Location Management";
                    NewLocationCode: Code[20];
                    WhichLocationQst: Label 'Which type of Location do you wish to buy?';
                    BasicTok: Label 'Basic (Price: %1)';
                    AdvTok: Label 'Advanced (Price: %1)';
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