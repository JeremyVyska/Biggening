codeunit 88026 "BCS Bot Check Assignment"
{
    procedure CheckAssignment(var BotInstance: Record "BCS Bot Instance")
    begin
        if (BotInstance."Assignment Code" = '') then
            exit;
        case BotInstance."Bot Type" of
            BotInstance."Bot Type"::Sales,
            BotInstance."Bot Type"::Purchasing:
                CheckNoOthersAssignedHere(BotInstance);
            BotInstance."Bot Type"::"Inventory-Basic",
            BotInstance."Bot Type"::"Inventory-Advanced",
            BotInstance."Bot Type"::Assembly,
            BotInstance."Bot Type"::Manufacturing:
                CheckLocationBotCapacity(BotInstance);
        end;
    end;

    local procedure CheckNoOthersAssignedHere(var BotInstance: Record "BCS Bot Instance")
    var
        BotInstance2: Record "BCS Bot Instance";
        BotAlreadyAssignedErr: Label 'Bot %1 is already assigned to %2';
    begin
        BotInstance2.SetFilter("Instance ID", '<>%1', BotInstance."Instance ID");
        BotInstance2.SetRange("Assignment Code", BotInstance."Assignment Code");
        if not BotInstance2.IsEmpty then begin
            BotInstance2.FindFirst();
            Error(BotAlreadyAssignedErr, BotInstance2.Designation, BotInstance."Assignment Code");
        end;
    end;

    local procedure CheckLocationBotCapacity(var BotInstance: Record "BCS Bot Instance")
    var
        Location: Record Location;
        LocationFullErr: Label 'Location %1 already has the maximum %2 bots assigned.';
    begin
        Location.Get(BotInstance."Assignment Code");
        Location.TestField("Maximum Bots");
        Location.CalcFields("Assigned Bots");
        if (Location."Assigned Bots" >= Location."Maximum Bots") then
            Error(LocationFullErr, BotInstance."Assignment Code", Location."Maximum Bots");
    end;
}
