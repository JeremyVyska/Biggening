page 88005 "BCS Bot Purchase"
{
    Caption = 'Buy a Bot';
    PageType = NavigatePage;
    AdditionalSearchTerms = 'bots,purchasing';
    SourceTable = "Company Information";

    layout
    {
        area(content)
        {
            group(BotTypeStep)
            {
                Visible = WhichStep = 1;
                Caption = 'Bot Type';
                InstructionalText = 'Select the Type of Bot and possibly which Tier';
                field(chooseBotType; WhichBotType)
                {
                    ApplicationArea = all;
                    Caption = 'Bot Types';

                    trigger OnValidate()
                    begin
                        SetControls();
                    end;
                }
            }
            group(MaterialCheckStep)
            {
                Visible = WhichStep = 2;
                Caption = 'Resources Check';
                InstructionalText = 'Review the Required Resources';
            }
            group(AssignmentStep)
            {
                Visible = WhichStep = 3;
                InstructionalText = 'Step 3';
            }
            group(ConfirmStep)
            {
                Visible = WhichStep = 4;
                InstructionalText = 'Step 4';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionBack)
            {
                ApplicationArea = All;
                Caption = 'Back';
                InFooterBar = true;
                Enabled = ActionBackAllowed;
                Image = PreviousRecord;

                trigger OnAction()
                begin
                    TakeStep(-1);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea = All;
                Caption = 'Next';
                InFooterBar = true;
                Enabled = ActionNextAllowed;
                Image = NextRecord;
                trigger OnAction()
                begin
                    TakeStep(1);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = All;
                Caption = 'Finish';
                InFooterBar = true;
                Enabled = ActionFinishAllowed;
                Image = Approve;

                trigger OnAction()
                var
                    BotTemplate: Record "BCS Bot Template";
                    BotMgmt: Codeunit "BCS Bot Management";
                begin
                    //TODO: Replace with correct bot template logic
                    BotTemplate.SetRange("Bot Type", WhichBotType);
                    if BotTemplate.FindFirst() then begin

                        Message(BotPurchasedMsg, BotMgmt.PurchaseBot(BotTemplate.Code));

                        CurrPage.Close();
                    end else
                        Error(NoBotTemplateFoundErr, WhichBotType);
                end;
            }
        }
    }

    local procedure SetControls()
    begin
        ActionBackAllowed := WhichStep > 1;
        ActionNextAllowed := (WhichStep < 4) AND (WhichBotType <> WhichBotType::" ");
        //TODO Allow/disallow based on criteria
        ActionFinishAllowed := WhichStep = 4;
    end;

    local procedure TakeStep(WhichDirection: Integer)
    begin
        WhichStep += WhichDirection;
        if WhichStep < 1 then
            WhichStep := 1;
        if WhichStep > 4 then
            WhichStep := 4;

        if WhichStep = 3 then begin
            //TODO - do we need to be here?
            if (WhichBotType in [WhichBotType::Sales, WhichBotType::Purchasing]) then begin

            end else
                if (WhichDirection > 0) then //Nexting
                    WhichStep := 4
                else  //Backing
                    WhichStep := 2;
        end;
        SetControls();
    end;

    trigger OnOpenPage()
    begin
        WhichStep := 1;
        SetControls();
    end;

    var
        WhichStep: Integer;
        WhichBotType: Enum "BCS Bot Type";
        ActionBackAllowed: Boolean;
        ActionNextAllowed: Boolean;
        ActionFinishAllowed: Boolean;
        BotPurchasedMsg: Label 'Bot %1 purchased.';
        NoBotTemplateFoundErr: Label 'No Bot Template of type %1 was found';

}
