codeunit 88025 "BCS Player Charge"
{

    procedure ChargeCash(ChargeAccount: Code[20]; ChargeAmount: Decimal; DocNo: Code[20]; PostingDesc: Text[100]): Boolean
    var
        GameSetup: Record "BCS Game Setup";
        GenJnl: Record "Gen. Journal Line";
        GenJnlPost: Codeunit "Gen. Jnl.-Post Line";
    begin
        GameSetup.Get();
        GenJnl.SetRange("Journal Template Name", 'GENERAL');
        GenJnl.SetRange("Journal Batch Name", 'DEFAULT');
        GenJnl.DeleteAll();
        GenJnl."Journal Template Name" := 'GENERAL';
        GenJnl."Journal Batch Name" := 'DEFAULT';
        GenJnl."Line No." := 10000;
        GenJnl."Account Type" := GenJnl."Account Type"::"G/L Account";
        GenJnl.Validate("Account No.", ChargeAccount);
        GenJnl.Validate("Document No.", DocNo);
        GenJnl.Validate("Posting Date", WorkDate());
        GenJnl.Validate("Bal. Account Type", GenJnl."Bal. Account Type"::"G/L Account");
        GenJnl.Validate("Bal. Account No.", GameSetup."Cash Account");
        GenJnl.Validate(Amount, ChargeAmount);
        GenJnl.Description := PostingDesc;
        GenJnl.Insert(true);
        Commit();
        exit(GenJnlPost.Run(GenJnl));
    end;

    procedure ChargeMaterial(MaterialCode: Code[20]; QtyToCharge: Decimal; DocNo: Code[20]; PostingDesc: Text[100])
    var
        Item: Record Item;
        Location: Record Location;
        WhseItemJnl: Record "Warehouse Journal Line";
        RemQtyToCharge: Decimal;
        QtyToReduce: Decimal;
        LoopSafety: Integer;
    begin
        Item.Get(MaterialCode);
        Item.CalcFields(Inventory);
        if (Item.Inventory < QtyToCharge) then
            Error(InsufficientItemsErr, MaterialCode, Item.Inventory, QtyToCharge);

        RemQtyToCharge := QtyToCharge;
        repeat
            LoopSafety := LoopSafety + 1;
            Location.SetRange("BCS Item Filter", MaterialCode);
            Location.SetFilter("Total Stock", '>0');

            // Try all the Basic Locations first
            Location.SetRange("Require Shipment", false);
            if Location.FindSet() then
                repeat
                    Location.CalcFields("Total Stock");
                    if (Location."Total Stock" > RemQtyToCharge) then
                        QtyToReduce := RemQtyToCharge
                    else
                        QtyToReduce := Location."Total Stock";
                    if AdjustOutSimple(MaterialCode, QtyToReduce, DocNo, Location.Code, PostingDesc) then
                        RemQtyToCharge := RemQtyToCharge - QtyToReduce;
                until (RemQtyToCharge = 0) OR (Location.Next() = 0);

        // TODO: Handle Advanced Locations
        until (RemQtyToCharge = 0) OR (LoopSafety > 100);
        if (RemQtyToCharge > 0) then
            Error(UnableToFindItems, MaterialCode, RemQtyToCharge);
    end;

    local procedure AdjustOutSimple(ItemNo: Code[20]; QtyToReduce: Decimal; DocNo: Code[20]; LocNo: Code[20]; PostingDesc: Text[100]): Boolean
    var
        ItemJnl: Record "Item Journal Line";
        ItemJnlPostLn: Codeunit "Item Jnl.-Post Line";
    begin
        ItemJnl.SetRange("Journal Template Name", 'ITEM');
        ItemJnl.SetRange("Journal Batch Name", 'DEFAULT');
        ItemJnl.DeleteAll();
        ItemJnl."Journal Template Name" := 'ITEM';
        ItemJnl."Journal Batch Name" := 'DEFAULT';
        ItemJnl."Line No." := 10000;
        ItemJnl."Entry Type" := ItemJnl."Entry Type"::"Negative Adjmt.";
        ItemJnl.Validate("Posting Date", WorkDate());
        ItemJnl.Validate("Document No.", DocNo);
        ItemJnl.Validate("Item No.", ItemNo);
        ItemJnl.Validate("Location Code", LocNo);
        ItemJnl.Validate(Quantity, QtyToReduce);
        ItemJnl.Description := PostingDesc;
        ItemJnl.Insert(true);
        Commit();
        exit(ItemJnlPostLn.Run(ItemJnl));
    end;




    var
        InsufficientItemsErr: Label 'You do not have enough of %1 in Inventory (%2/%3).';
        UnableToFindItems: Label 'Unable to locate sufficient quantity of %1 in Locations (%2)';
}
