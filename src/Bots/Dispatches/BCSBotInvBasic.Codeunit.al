codeunit 88008 "BCS Bot Inv-Basic"
{
    TableNo = "BCS Bot Instance";

    trigger OnRun()
    var
        PurchHeader: Record "Purchase Header";
        SalesHeader: Record "Sales Header";
        DocsHandled: Array[4] of Integer;  //  Full PO, Partial PO, Full SO, Partial SO
        i: Integer;
        LinesHandled: Integer;
        ActivityCompleted: Boolean;
    begin
        // Safety Measure
        if (Rec."Bot Tier" = 0) then begin
            Rec."Bot Tier" := 1;
            Rec.Modify(true);
        end;
        if (rec."Maximum Doc. Lines Per Op" = 0) then begin
            rec."Maximum Doc. Lines Per Op" := 1;
            Rec.Modify(true);
        end;

        if rec."Assignment Code" = '' then
            SetResult(UnassignedBotMsg, MyResult."Action Type"::Idle)
        else begin
            for i := 1 to Rec.GetOpsPerDay() do begin
                ActivityCompleted := false;
                // Look for Prior To WorkDate Shipments
                if not ActivityCompleted then begin
                    SalesHeader.SetCurrentKey("Posting Date");
                    SalesHeader.SetAscending("Posting Date", false);
                    SalesHeader.SetRange("Location Code", Rec."Assignment Code");
                    SalesHeader.SetFilter("Posting Date", '..%1', CalcDate('<-1D>', WorkDate()));
                    if SalesHeader.FindSet(false) then
                        repeat
                            if SalesHasOutstanding(SalesHeader) then begin
                                LinesHandled := HandleShipment(Rec, SalesHeader); //COMMITS
                                if (LinesHandled < 0) then // Fully Received
                                    DocsHandled[3] := DocsHandled[3] + 1
                                else
                                    if (LinesHandled > 0) then
                                        DocsHandled[4] := DocsHandled[4] + 1;
                                if (LinesHandled <> 0) then
                                    ActivityCompleted := true;
                            end;
                        until (SalesHeader.Next() = 0) or ActivityCompleted;
                end;

                // Look for Prior to WorkDate Receipts
                if not ActivityCompleted then begin
                    PurchHeader.SetCurrentKey("Posting Date");
                    PurchHeader.SetAscending("Posting Date", false);
                    PurchHeader.SetRange("Location Code", Rec."Assignment Code");
                    PurchHeader.SetFilter("Posting Date", '..%1', CalcDate('<-1D>', WorkDate()));
                    if PurchHeader.FindSet(false) then
                        repeat
                            if PurchHasOutstanding(PurchHeader) then begin
                                LinesHandled := HandleReceipt(Rec, PurchHeader); //COMMITS
                                if (LinesHandled < 0) then // Fully Received
                                    DocsHandled[1] := DocsHandled[1] + 1
                                else
                                    if (LinesHandled > 0) then
                                        DocsHandled[2] := DocsHandled[2] + 1;
                                if (LinesHandled <> 0) then
                                    ActivityCompleted := true;
                            end;
                        until (PurchHeader.Next() = 0) or ActivityCompleted;
                end;

                // Look for Current Workdate shipments
                if not ActivityCompleted then begin
                    SalesHeader.SetRange("Posting Date", WorkDate());
                    if SalesHeader.FindSet(false) then
                        repeat
                            if SalesHasOutstanding(SalesHeader) then begin
                                LinesHandled := HandleShipment(Rec, SalesHeader); //COMMITS
                                if (LinesHandled < 0) then // Fully Received
                                    DocsHandled[3] := DocsHandled[3] + 1
                                else
                                    if (LinesHandled > 0) then
                                        DocsHandled[4] := DocsHandled[4] + 1;
                                if (LinesHandled <> 0) then
                                    ActivityCompleted := true;
                            end;
                        until (SalesHeader.Next() = 0) or ActivityCompleted;
                end;

                // Look for Current Workdate receipt
                if not ActivityCompleted then begin
                    PurchHeader.SetRange("Posting Date", WorkDate());
                    if PurchHeader.FindSet(false) then
                        repeat
                            if PurchHasOutstanding(PurchHeader) then begin
                                LinesHandled := HandleReceipt(Rec, PurchHeader); //COMMITS
                                if (LinesHandled < 0) then // Fully Received
                                    DocsHandled[1] := DocsHandled[1] + 1
                                else
                                    if (LinesHandled > 0) then
                                        DocsHandled[2] := DocsHandled[2] + 1;
                                if (LinesHandled <> 0) then
                                    ActivityCompleted := true;
                            end;
                        until (PurchHeader.Next() = 0) or ActivityCompleted;
                end;
            end;

            if (DocsHandled[1] = 0) and (DocsHandled[2] = 0) and (DocsHandled[3] = 0) and (DocsHandled[4] = 0) then
                SetResult(NoWorkAvailableMsg, MyResult."Action Type"::Idle)
            else
                SetResult(StrSubstNo(OperationSuccessMsg, DocsHandled[1], DocsHandled[2], DocsHandled[3], DocsHandled[4]), MyResult."Action Type"::Activity)
        end;

    end;

    local procedure PurchHasOutstanding(var PurchaseHeader: Record "Purchase Header"): Boolean
    var
        PurchaseLine: Record "Purchase Line";
    begin
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetFilter("Outstanding Quantity", '>0');
        Exit(not PurchaseLine.IsEmpty);
    end;

    local procedure HandleReceipt(var WhichBot: Record "BCS Bot Instance"; var PurchaseHeader: Record "Purchase Header"): Integer
    var
        PurchaseLine: Record "Purchase Line";
        i: Integer;
    begin
        PurchaseLine.SetRange("Document Type", PurchaseHeader."Document Type");
        PurchaseLine.SetRange("Document No.", PurchaseHeader."No.");
        PurchaseLine.SetFilter("Outstanding Quantity", '>0');
        if PurchaseLine.Count <= WhichBot."Maximum Doc. Lines Per Op" then begin
            PostReceipt(PurchaseHeader); //COMMITS
            exit(-1);
        end else begin
            // All the PO lines, 0 our the Qty to Receive.
            PurchaseLine.ModifyAll("Qty. to Receive", 0);
            PurchaseLine.ModifyAll("Qty. to Receive (base)", 0);

            // Iterate through the PO Lines up to the max lines of the bot,
            // setting Qty to Receive
            for i := 1 to WhichBot."Maximum Doc. Lines Per Op" do begin
                PurchaseLine.Validate("Qty. to Receive", PurchaseLine."Outstanding Quantity");
                PurchaseLine.Modify(true);
            end;
            PostReceipt(PurchaseHeader); //COMMITS
            exit(WhichBot."Maximum Doc. Lines Per Op");
        end;

    end;

    local procedure PostReceipt(var PurchaseHeader: Record "Purchase Header")
    var
        PurchPost: Codeunit "Purch.-Post";
    begin
        PurchaseHeader.Receive := true;
        PurchaseHeader.Invoice := false;
        PurchPost.SetPostingFlags(PurchaseHeader);
        PurchPost.Run(PurchaseHeader);
        Commit();
    end;

    local procedure SalesHasOutstanding(var SalesHeader: Record "Sales Header"): Boolean
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter("Outstanding Quantity", '>0');
        Exit(not SalesLine.IsEmpty);
    end;

    local procedure HandleShipment(var WhichBot: Record "BCS Bot Instance"; var SalesHeader: Record "Sales Header"): Integer
    var
        SalesLine: Record "Sales Line";
        i: Integer;
    begin
        SalesLine.SetRange("Document Type", SalesHeader."Document Type");
        SalesLine.SetRange("Document No.", SalesHeader."No.");
        SalesLine.SetFilter("Outstanding Quantity", '>0');
        if SalesLine.Count <= WhichBot."Maximum Doc. Lines Per Op" then begin
            PostShipment(SalesHeader); //COMMITS
            exit(-1);
        end else begin
            // All the PO lines, 0 our the Qty to Receive.
            SalesLine.ModifyAll("Qty. to Ship", 0);
            SalesLine.ModifyAll("Qty. to Ship (base)", 0);

            // Iterate through the SO Lines up to the max lines of the bot,
            // setting Qty to Receive
            for i := 1 to WhichBot."Maximum Doc. Lines Per Op" do begin
                SalesLine.Validate("Qty. to Ship", SalesLine."Outstanding Quantity");
                SalesLine.Modify(true);
            end;
            PostShipment(SalesHeader); //COMMITS
            exit(WhichBot."Maximum Doc. Lines Per Op");
        end;

    end;

    local procedure PostShipment(var SalesHeader: Record "Sales Header")
    var
        SalesPost: Codeunit "Sales-Post";
    begin
        SalesHeader.Ship := true;
        SalesHeader.Invoice := false;
        SalesPost.SetPostingFlags(SalesHeader);
        SalesPost.Run(SalesHeader);
        Commit();
    end;

    procedure GetResult(var DispatchResult: Record "BCS Dispatch Result" temporary)
    begin
        Clear(DispatchResult);
        DispatchResult.TransferFields(MyResult);
    end;

    procedure SetResult(newText: Text[200]; whichType: Enum "BCS Bot Result Type")
    begin
        MyResult."Action Type" := whichType;
        MyResult.ResultText := newText;
    end;


    var
        MyResult: Record "BCS Dispatch Result" temporary;
        UnassignedBotMsg: Label 'Not assigned to a Location, sleeping.';
        OperationSuccessMsg: Label 'Received %1 fully and %2 partially.  Shipped %3 fully and %4 partially.', Comment = '%1 %2 are a count of received orders, full and partial. %3 %4 are a count of shipped orders, full and partial';
        NoWorkAvailableMsg: Label 'No documents waiting to be processed, sleeping.';
}
