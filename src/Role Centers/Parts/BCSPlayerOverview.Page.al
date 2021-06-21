page 88035 "BCSPlayerOverview"
{
    Caption = 'Player Overview';
    PageType = ListPart;
    SourceTable = "BCS Player";
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field';
                    ApplicationArea = All;
                }
                field("Company Name"; Rec."Company Name")
                {
                    ToolTip = 'Specifies the value of the Company Name field';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Company Display Name"; Rec."Company Display Name")
                {
                    ToolTip = 'Specifies the value of the Company Display Name field';
                    ApplicationArea = All;
                }
                field(Wealth; Rec.Wealth)
                {
                    ToolTip = 'Specifies the value of the Wealth field';
                    ApplicationArea = All;
                }

            }
        }
    }

    trigger OnOpenPage()
    var
        BCSSeason: Record "BCS Season";
        BCSGameSetup: Record "BCS Game Setup";
        CompanyInfo: Record "Company Information";
    begin
        BCSSeason.SetRange(Active, true);
        if BCSSeason.FindFirst() then;
        Rec.SetRange("Season Filter", BCSSeason."No.");
        Rec.SetRange("Game Date Filter", BCSGameSetup."Game Date");
        rec.CalcFields("Current Rank");
    end;
}
