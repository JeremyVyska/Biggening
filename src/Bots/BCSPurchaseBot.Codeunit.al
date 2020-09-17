codeunit 88027 "BCS Purchase Bot"
{
    trigger OnRun()
    begin
        Page.RunModal(Page::"BCS Bot Purchase Wizard");
        Page.Run(Page::"BCS Bot Instance List");
    end;
}
