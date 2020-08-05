codeunit 88017 "BCS Is Master Company"
{
    procedure IsMC(): Boolean
    var
        CompanyInformation: Record "Company Information";
    begin
        if CompanyInformation.get() then
            exit(CompanyInformation."Master Company")
        else
            exit(false);
    end;

}
