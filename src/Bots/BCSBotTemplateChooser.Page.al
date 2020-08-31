page 88027 "BCS Bot Template Chooser"
{

    Caption = 'BCS Bot Template Chooser';
    PageType = ListPart;
    SourceTable = "BCS Bot Template";

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Base Price"; "Base Price")
                {
                    ApplicationArea = All;
                }
                field(Materials; Materials)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure GetSelected(): Code[20]
    begin
        exit(Rec.Code);
    end;
}
