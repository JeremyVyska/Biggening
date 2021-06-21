page 88037 "BCS Job Queue Overview"
{

    Caption = 'BCS Job Queue Overview';
    PageType = ListPart;
    SourceTable = "Job Queue Entry";
    SourceTableTemporary = true;
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        BCSPlayer: Record "BCS Player";
        JobQueue2: Record "Job Queue Entry";
    begin
        JobQueue2.SetRange("Object ID to Run", Codeunit::"BCS Player Heartbeat Listener");
        if BCSPlayer.FindSet(false) then
            repeat
                JobQueue2.ChangeCompany(BCSPlayer."Company Name");
                if JobQueue2.FindFirst() then begin
                    Rec.TransferFields(JobQueue2);
                    rec.Description := BCSPlayer."Company Name";
                    Rec.insert(false);
                end;
            until BCSPlayer.Next() = 0;
    end;

}
