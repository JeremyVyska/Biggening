codeunit 88024 "BCS Player Doc. Posting"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"BCS Player Heartbeat Listener", 'OnHeartbeat', '', true, true)]
    local procedure "BCS Player Heartbeat Listener_OnHeartbeat"()
    begin
        PostOldDocs();
    end;

    procedure PostOldDocs()
    var
        SalesHeader: Record "Sales Header";
        PurchHeader: Record "Purchase Header";
    begin
        // Purchase Documents
        PurchHeader.Reset();
        PurchHeader.SetRange("Document Type", PurchHeader."Document Type"::Order);
        PurchHeader.SetFilter("Posting Date", '..%1', CalcDate('<-1W>', WorkDate()));
        PurchHeader.SetRange(Status, PurchHeader.Status::Released);
        if PurchHeader.FindSet(true, true) then
            repeat
                PostPO(PurchHeader."No.");
            until PurchHeader.Next() = 0;
        Commit();

        // Sales Documents
        SalesHeader.Reset();
        SalesHeader.SetRange("Document Type", SalesHeader."Document Type"::Order);
        SalesHeader.SetFilter("Posting Date", '..%1', CalcDate('<-1W>', WorkDate()));
        SalesHeader.SetRange(Status, SalesHeader.Status::Released);
        if SalesHeader.FindSet(true, true) then
            repeat
                PostSO(SalesHeader."No.");
            until SalesHeader.Next() = 0;
        Commit();
    end;

    local procedure PostPO(PurchaseOrderNo: Code[20])
    var
        PurchaseHeader: Record "Purchase Header";
        PurchPost: Codeunit "Purch.-Post";
    begin
        if PurchaseHeader.Get(PurchaseHeader."Document Type"::Order, PurchaseOrderNo) then begin
            PurchaseHeader.Receive := false;
            PurchaseHeader.Invoice := true;
            PurchPost.SetPostingFlags(PurchaseHeader);
            PurchPost.Run(PurchaseHeader);
        end;
    end;

    local procedure PostSO(SalesOrderNo: Code[20])
    var
        SalesHeader: Record "Sales Header";
        SalesPost: Codeunit "Sales-Post";
    begin
        if SalesHeader.Get(SalesHeader."Document Type"::Order, SalesOrderNo) then begin
            SalesHeader.Ship := false;
            SalesHeader.Invoice := true;
            SalesPost.SetPostingFlags(SalesHeader);
            SalesPost.Run(SalesHeader);
        end;
    end;
}
