page 88008 "BCS Power Usage Ledger"
{

    ApplicationArea = All;
    Caption = 'BCS Power Usage Ledger';
    PageType = List;
    SourceTable = "BCS Power Ledger";
    UsageCategory = History;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Entry No. field';
                }
                field("Entry Type"; "Entry Type")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Entry Type field';
                }
                field("Bot Instance"; "Bot Instance")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Bot Instance field';
                }
                field("Bot Type"; "Bot Type")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Bot Type field';
                }
                field("Posted to G/L"; "Posted to G/L")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Posted to G/L field';
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Posting Date field';
                }
                field("Power Usage"; "Power Usage")
                {
                    ApplicationArea = All;
                    ToolTip='Specifies the value of the Power Usage field';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Post)
            {
                Caption = 'Post';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                Image = Post;
                ToolTip='Executes the Post action';

                trigger OnAction()
                var
                    PowerPost: Codeunit "BCS Power Posting";
                begin
                    PowerPost.PostYesterdayPower();
                end;
            }
        }
    }
}
