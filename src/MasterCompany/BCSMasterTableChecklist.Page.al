page 88029 "BCS Master Table Checklist"
{

    ApplicationArea = All;
    Caption = 'BCS Master Table Checklist';
    PageType = List;
    SourceTable = AllObjWithCaption;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(CheckedControl; LineChecked)
                {
                    Caption = 'Include';
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the LineChecked field';

                    trigger OnValidate()
                    begin
                        SetCheckedStatus("Object ID", LineChecked);
                    end;
                }
                field("Object ID"; "Object ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object ID field';
                }
                field("Object Name"; "Object Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Name field';
                }
                field("Object Caption"; "Object Caption")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Object Caption field';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.FilterGroup(11);
        Rec.SetRange("Object Type", "Object Type"::Table);
        Rec.FilterGroup(0);
    end;

    trigger OnAfterGetRecord()
    begin
        LineChecked := GetCheckedStatus(Rec."Object ID");
    end;

    procedure GetCheckedStatus(WhichTableNo: Integer): Boolean
    var
        MasterTables: Record "BCS Master Tables";
    begin
        MasterTables.SetRange("Table No.", WhichTableNo);
        exit(not MasterTables.IsEmpty);  // exits true if there's a record
    end;

    procedure SetCheckedStatus(WhichTableNo: Integer; newStatus: Boolean)
    var
        MasterTables: Record "BCS Master Tables";
    begin
        if newStatus then begin
            if not MasterTables.get(WhichTableNo) then begin
                MasterTables."Table No." := WhichTableNo;
                MasterTables.insert();
            end;
        end else
            if MasterTables.get(WhichTableNo) then
                MasterTables.Delete();
    end;

    var
        LineChecked: Boolean;
}
