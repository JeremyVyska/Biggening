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
                    ToolTip = 'Specifies the value of the Bot Types field';

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
                    ToolTip = 'Specifies the value of the Assignment Code field';

                    trigger OnValidate()
                    var
                        BCSCheckAssignment: Codeunit "BCS Bot Check Assignment";
                    begin
                        BCSCheckAssignment.CheckAssignment(Rec);
                    end;
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
                ToolTip = 'Executes the Back action';

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
                ToolTip = 'Executes the Next action';
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
                ToolTip = 'Executes the Finish action';

                trigger OnAction()
                var
                    BotTemplate: Record "BCS Bot Template";
                    BotMgmt: Codeunit "BCS Bot Management";
                begin
                    //TODO: Replace with correct bot template logic
                    BotTemplate.SetRange("Bot Type", Rec."Bot Type");
                    if BotTemplate.FindFirst() then begin

                        Message(BotPurchasedMsg, BotMgmt.PurchaseBot(ReqToShow, BotTemplate.Code));

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
        //ActionNextAllowed := (WhichStep < 4) AND (Rec."Bot Type" <> Rec."Bot Type"::" ");

        // FALSE if WhichStep = 4
        // FALSE if there's not Bot Type
        // FALSE IF we've calculated the materials AND there's a shortage
        ActionNextAllowed := NOT ((WhichStep = 4) OR
                                   (Rec."Bot Type" = Rec."Bot Type"::" ") OR
                                   (not ReqToShow.IsEmpty and MissingMaterials));

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

        // If we're back at step 1, reset the Materials stages
        if WhichStep = 1 then begin
            MissingMaterials := false;
            ReqToShow.DeleteAll();
        end;

        if WhichStep = 2 then
            // We're moving to materials requirements.
            //Message('You picked: %1', CurrPage.TemplatePicker.Page.GetSelected());
            populateRequirements();

        if WhichStep = 3 then
            //TODO - do we need to be here?
            if not (Rec."Bot Type" in [Rec."Bot Type"::Sales, Rec."Bot Type"::Purchasing, Rec."Bot Type"::"Inventory-Basic", Rec."Bot Type"::"Inventory-Advanced"]) then
                if (WhichDirection > 0) then //Nexting
                    WhichStep := 4
                else  //Backing
                    WhichStep := 2;
        SetControls();
    end;

    local procedure populateRequirements()
    var
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

        ReqToShow.SetRange(Shortage, true);
        MissingMaterials := not ReqToShow.IsEmpty;
        ReqToShow.SetRange(Shortage);
    end;


    var
        ReqToShow: Record "BCS Resource Check Buffer" temporary;
        WhichStep: Integer;
        ActionBackAllowed: Boolean;
        ActionNextAllowed: Boolean;
        ActionFinishAllowed: Boolean;
        ShowBotTemplates: Boolean;
        BotPurchasedMsg: Label 'Bot %1 purchased.', Comment = '%1 is which Bot Designator is the new purchase.';
        NoBotTemplateFoundErr: Label 'No Bot Template of type %1 was found', Comment = '%1 is from the enum of the Bot Type that we are checking for a Template of';

        MissingMaterials: Boolean;
}
