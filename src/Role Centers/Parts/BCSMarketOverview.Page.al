page 88036 "BCS Market Overview"
{
    Caption = 'Market Overview';
    PageType = ListPart;
    SourceTable = "BCS Market Price";
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field';
                    ApplicationArea = All;
                }
                field("Market Price"; Rec."Market Price")
                {
                    ToolTip = 'Specifies the value of the Market Price field';
                    ApplicationArea = All;
                }
                field(ItemCategory; ItemCategory)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ItemCategory field';
                }
                field(ProdPostingGroup; ProdPostingGroup)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the ProdPostingGroup field';
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Item: Record Item;
    begin
        Clear(ItemCategory);
        Clear(ProdPostingGroup);
        if Item.get("Item No.") then begin
            ItemCategory := Item."Item Category Code";
            ProdPostingGroup := Item."Gen. Prod. Posting Group";
        end;
    end;

    var
        ItemCategory: Code[20];
        ProdPostingGroup: Code[20];

}
