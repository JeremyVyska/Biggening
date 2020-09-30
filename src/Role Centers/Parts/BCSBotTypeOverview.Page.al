page 88032 "BCS Bot Type Overview"
{

    Caption = 'BCS Bot Type Overview';
    PageType = ListPart;
    SourceTable = "BCS Bot Instance";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Bot Type"; "Bot Type")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Bot Type field';
                }
                field("Research Points Per Op"; "Research Points Per Op")
                {
                    Caption = 'Bot Count';
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Bot Count field';
                }
                field("Power Per Day"; "Power Per Day")
                {
                    Caption = 'Total Power Per Day';
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Total Power Per Day field';
                }
                field("Operations Per Day"; "Operations Per Day")
                {
                    Caption = 'Total Ops. Per Day';
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Total Ops. Per Day field';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        GenerateOverview();
    end;

    procedure GenerateOverview()
    var
        Bots: Record "BCS Bot Instance";
        CurrentBotTypes: List of [Integer];
        i: Integer;
    begin
        if not Rec.IsTemporary then
            Error('What?');
        Rec.DeleteAll();
        CurrentBotTypes := Rec."Bot Type".Ordinals();
        foreach i in CurrentBotTypes do begin
            Bots.SetRange("Bot Type", "BCS Bot Type".FromInteger(i));
            Rec."Instance ID" := i;
            Rec."Bot Type" := "BCS Bot Type".FromInteger(i);
            Rec."Research Points Per Op" := Bots.Count;
            Bots.CalcSums("Power Per Day", "Operations Per Day");
            Rec."Power Per Day" := Bots."Power Per Day";
            Rec."Operations Per Day" := Bots."Operations Per Day";
            Rec.Insert(false);
        end;
    end;
}
