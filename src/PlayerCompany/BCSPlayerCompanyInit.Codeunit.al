codeunit 88014 "BCS Player Company Init"
{

    [EventSubscriber(ObjectType::Table, Database::Company, 'OnAfterInsertEvent', '', true, true)]
    local procedure InitializePlayerCompany(var Rec: Record Company; RunTrigger: Boolean)
    begin
        if not RunTrigger then
            exit;

        CopyDefaults(Rec);
        CopyBaseResearch(Rec);
    end;

    local procedure CopyDefaults(var Rec: Record Company)
    var
        BCSMaster: Codeunit "BCS Master Company";
    begin
        BCSMaster.CopySetupToCompany(Rec.Name);
    end;

    local procedure CopyBaseResearch(var Rec: Record Company)
    var
        BCSResearch: Record "BCS Research";
        BCSResPlayer: Record "BCS Research Progress";
    begin
        BCSResearch.SetRange(Prerequisites, 0);
        IF BCSResearch.FindSet() then
            repeat
                BCSResPlayer.ChangeCompany(Rec.Name);
                BCSResPlayer.TransferFields(BCSResearch);
                BCSResPlayer.Insert(true);
            until BCSResearch.Next() = 0;
    end;
}