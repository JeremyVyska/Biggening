page 88005 "BCS Bot Purchase Wizard"
{
    Caption = 'Buy a Bot';
    PageType = NavigatePage;
    AdditionalSearchTerms = 'bots,purchasing';
    SourceTable = "BCS Bot Instance";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            group(BotTypeStep)
            {
                Visible = WhichStep = 1;
                Caption = 'Bot Type';
                InstructionalText = 'Select the Type of Bot and possibly which Tier';
                field(chooseBotType; Rec."Bot Type")
                {
                    ApplicationArea = all;
                    Caption = 'Bot Types';

                    trigger OnValidate()
                    var
                        BotTemplate: Record "BCS Bot Template";
                    begin
                        SetControls();

                        // is there only 1 or more Templates for the Type?
                        BotTemplate.SetRange("Bot Type", Rec."Bot Type");
                        ShowBotTemplates := (BotTemplate.Count > 1);

                    end;
                }
                part(TemplatePicker; "BCS Bot Template Chooser")
                {
                    Caption = 'TemplatePicker';
                    SubPageLink = "Bot Type" = field("Bot Type");
                    Visible = ShowBotTemplates;
                    Editable = false;
                    UpdatePropagation = both;
                }
            }
            group(MaterialCheckStep)
            {
                Visible = WhichStep = 2;
                Caption = 'Resources Check';
                InstructionalText = 'Review the Required Resources';
                part(ResourceChecklist; "BCS Resource Checklist")
                {

                }
            }
            group(AssignmentStep)
            {
                Visible = WhichStep = 3;
                InstructionalText = 'Step 3';

                field(Assignment; Rec."Assignment Code")
                {
                    Caption = 'Assignment Code';
                    ApplicationArea = all;
                }
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
                    BotTemplate.SetRange("Bot Type", Rec."Bot Type");
                    if BotTemplate.FindFirst() then begin

                        Message(BotPurchasedMsg, BotMgmt.PurchaseBot(BotTemplate.Code));

                        CurrPage.Close();
                    end else
                        Error(NoBotTemplateFoundErr, Rec."Bot Type");
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        WhichStep := 1;
        SetControls();
        Rec.Init();
        Rec.Insert();
    end;



    local procedure SetControls()
    begin
        ActionBackAllowed := WhichStep > 1;
        ActionNextAllowed := (WhichStep < 4) AND (Rec."Bot Type" <> Rec."Bot Type"::" ");
        //TODO Allow/disallow based on criteria
        ActionFinishAllowed := WhichStep = 4;
    end;

    local procedure TakeStep(WhichDirection: Integer)
    begin
        WhichStep += WhichDirection;
        // Floor & Ceiling check
        if WhichStep < 1 then
            WhichStep := 1;
        if WhichStep > 4 then
            WhichStep := 4;

        if WhichStep = 2 then begin
            // We're moving to materials requirements.
            //Message('You picked: %1', CurrPage.TemplatePicker.Page.GetSelected());
            populateRequirements();
        end;

        if WhichStep = 3 then begin
            //TODO - do we need to be here?
            if (Rec."Bot Type" in [Rec."Bot Type"::Sales, Rec."Bot Type"::Purchasing, Rec."Bot Type"::"Inventory-Basic", Rec."Bot Type"::"Inventory-Advanced"]) then begin

            end else
                if (WhichDirection > 0) then //Nexting
                    WhichStep := 4
                else  //Backing
                    WhichStep := 2;
        end;
        SetControls();
    end;

    local procedure populateRequirements()
    var
        ReqToShow: Record "BCS Resource Check Buffer" temporary;
        BotTemplate: Record "BCS Bot Template";
        BCSBotMgt: Codeunit "BCS Bot Management";
    begin
        if (ShowBotTemplates) then
            BotTemplate.Get(CurrPage.TemplatePicker.Page.GetSelected())
        else begin
            BotTemplate.SetRange("Bot Type", Rec."Bot Type");
            BotTemplate.FindFirst();
        end;
        BCSBotMgt.GenerateReqBuffer(ReqToShow, BotTemplate);
        CurrPage.ResourceChecklist.Page.SetData(ReqToShow);
    end;


    var
        WhichStep: Integer;
        ActionBackAllowed: Boolean;
        ActionNextAllowed: Boolean;
        ActionFinishAllowed: Boolean;
        ShowBotTemplates: Boolean;
        BotPurchasedMsg: Label 'Bot %1 purchased.';
        NoBotTemplateFoundErr: Label 'No Bot Template of type %1 was found';

}
