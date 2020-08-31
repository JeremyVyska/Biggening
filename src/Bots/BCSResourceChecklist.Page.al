page 88028 "BCS Resource Checklist"
{

    Caption = 'Resource Checklist';
    PageType = ListPart;
    SourceTable = "BCS Resource Check Buffer";
    SourceTableTemporary = true;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Description)
                {
                    ApplicationArea = All;
                    StyleExpr = LineStyle;
                }
                field(Requirement; Requirement)
                {
                    ApplicationArea = All;
                    StyleExpr = LineStyle;
                }
                field(Inventory; Inventory)
                {
                    ApplicationArea = All;
                    StyleExpr = LineStyle;
                }
                field(LineStyle; LineStyle)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }

    procedure SetData(var NewDataToShow: Record "BCS Resource Check Buffer" temporary)
    begin
        Rec.DeleteAll();
        if NewDataToShow.FindSet() then
            repeat
                Rec := NewDataToShow;
                rec.Insert()
            until NewDataToShow.Next() = 0;
        if Rec.FindFirst() then;
    end;
}
