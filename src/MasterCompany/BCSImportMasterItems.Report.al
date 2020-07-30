report 88000 "BCS Import Master Items"
{
    Caption = 'Import Master Items';
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;


    requestpage
    {
        layout
        {
            area(Content)
            {
            }
        }

        trigger OnQueryClosePage(CloseAction: Action): Boolean
        begin
            if CloseAction = Action::OK then begin
                if (UploadIntoStream('Upload Master Items', '', '', OurFilename, InS)) then begin
                    if (OurFilename = '') then
                        exit(false);
                    WhichSheet := ExcelBuf.SelectSheetsNameStream(InS);
                    if WhichSheet = '' then
                        exit(true);
                end;
            end;
        end;
    }

    trigger OnPreReport()
    var
        MasterItem: Record "BCS Master Item";
        MasterBOM: Record "BCS Master Item BOM";
        WhichMasterItem: Code[20];
        BomItem: Code[20];
        QuantityAsText: Text;
        RowNo: Integer;
        i: Integer;
        QuantityToUpdate: Decimal;
    begin
        ExcelBuf.OpenBookStream(InS, WhichSheet);
        ExcelBuf.ReadSheet();

        ExcelBuf.SetFilter("Row No.", '>1');
        if ExcelBuf.FindSet() then
            repeat
                RowNo := ExcelBuf."Row No.";

                // Create/Update Item, PK Col 1, Col 2-4
                WhichMasterItem := CopyStr(GetCellValue(RowNo, 1), 1, MaxStrLen(WhichMasterItem));
                if (MasterItem.Get(WhichMasterItem)) then begin
                    // Found that item, update it
                    MasterItem.Validate(Description, GetCellValue(RowNo, 2));
                    MasterItem.Validate("Prod. Posting Group", GetCellValue(RowNo, 3));
                    MasterItem.Validate("Item Category Code", GetCellValue(RowNo, 4));
                    MasterItem.Modify(true);
                end else begin
                    // Create the item
                    MasterItem.Validate(Code, WhichMasterItem);
                    MasterItem.Validate(Description, GetCellValue(RowNo, 2));
                    MasterItem.Validate("Prod. Posting Group", GetCellValue(RowNo, 3));
                    MasterItem.Validate("Item Category Code", GetCellValue(RowNo, 4));
                    MasterItem.Insert(true);
                end;
                ;

                // Create/Update/Delete Item BOM, Col 5-10 BOM Simple Items
                for i := 5 to 10 do begin
                    QuantityAsText := GetCellValue(RowNo, i);
                    if QuantityAsText <> '' then begin
                        Evaluate(QuantityToUpdate, GetCellValue(RowNo, i));
                        case i of
                            5:
                                BomItem := '1000';
                            6:
                                BomItem := '1001';
                            7:
                                BomItem := '1002';
                            8:
                                BomItem := '1003';
                            9:
                                BomItem := '1004';
                            10:
                                BomItem := '1005';
                        end;
                        //Check if it exists
                        MasterBOM.SetRange("Item No.", WhichMasterItem);
                        MasterBOM.SetRange("Master Item No.", BomItem);
                        if MasterBOM.FindFirst() then begin
                            // if the QtyToUpdate = 0, delete, else modify
                            if (QuantityToUpdate <> 0) then
                                if (MasterBOM.Quantity <> QuantityToUpdate) then begin
                                    MasterBOM.Quantity := QuantityToUpdate;
                                    MasterBOM.Modify(true);
                                end
                                else
                                    MasterBOM.Delete(true);
                        end else begin
                            // if not make it.
                            MasterBOM."Item No." := WhichMasterItem;
                            MasterBOM."Line No." := 0;
                            MasterBOM."Master Item No." := BomItem;
                            MasterBOM.Quantity := QuantityToUpdate;
                            MasterBOM.Insert(true);
                        end;
                    end;
                end;

            // Create/Update BOM Col 11 - Complex Items

            // Create/Update Routing Col 12 - steps

            until ExcelBuf.Next() = 0;
    end;

    local procedure GetCellValue(RowNo: Integer; ColNo: Integer) Result: Text
    var
        StartingPosition: Text;
    begin
        StartingPosition := ExcelBuf.GetPosition();
        if ExcelBuf.Get(RowNo, ColNo) then
            Result := ExcelBuf."Cell Value as Text";
        ExcelBuf.SetPosition(StartingPosition);
        ExcelBuf.Find();
    end;

    var
        ExcelBuf: Record "Excel Buffer" temporary;
        InS: InStream;
        OurFilename: Text;
        WhichSheet: Text;
}