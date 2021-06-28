codeunit 88000 "BCS Master Company"
{
    procedure CopySetupToCompany(PlayerCompany: Text[30])
    var
        MasterTables: Record "BCS Master Tables";
    begin
        if MasterTables.FindSet() then
            repeat
                CopyToCompanyTable(PlayerCompany, MasterTables."Table No.");
            until MasterTables.Next() = 0;
    end;

    local procedure CopyToCompanyTable(DestCompanyName: Text[30]; TableNo: Integer)
    var
        SourceRecRef: RecordRef;
        DestRecRef: RecordRef;
        SourceFieldRef: FieldRef;
        DestFieldRef: FieldRef;
        i: Integer;
    begin
        SourceRecRef.Open(TableNo);
        DestRecRef.Open(TableNo, false, DestCompanyName);
        if SourceRecRef.FindSet() then
            repeat
                //Copy all the fields from Src to Dest
                for i := 1 to SourceRecRef.FieldCount do begin
                    SourceFieldRef := SourceRecRef.FieldIndex(i);
                    DestFieldRef := DestRecRef.FieldIndex(i);
                    if (SourceFieldRef.Class = FieldClass::Normal) then
                        DestFieldRef.Value(SourceFieldRef.Value);

                    /* Todo:   This *works* and doesn't throw an error, sure
                        but, it's filling up the event log with warning Telemetry data on each failed record to insert.
                        messy!
                    */
                    if not DestRecRef.Insert() then
                        DestRecRef.Modify();
                end;
            until SourceRecRef.Next() = 0;
    end;
}