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
                    ToolTip='Specifies the value of the Code field';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Description field';
                }
                field("Base Price"; "Base Price")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Base Price field';
                }
                field(Materials; Materials)
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Materials field';
                }
            }
        }
    }

    procedure GetSelected(): Code[20]
    begin
        exit(Rec.Code);
    end;
}
