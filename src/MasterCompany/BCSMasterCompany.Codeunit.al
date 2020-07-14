codeunit 88000 "BCS Master Company"
{
    // Customer - insert/modify/delete
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', false, false)]
    local procedure BCSMasterCustomerInserted(var Rec: Record Customer; RunTrigger: Boolean)
    var
        Company: Record Company;
        Customer: Record Customer;
    begin
        if not RunTrigger then
            exit;
        if not IsMasterCompany() then
            exit;

        // For each company in the databse, if it is NOT the current company, insert a copy
        if Company.FindSet(false) then
            repeat
                if Company.Name <> CompanyName() then begin
                    Customer.ChangeCompany(Company.Name);
                    Customer.Init();
                    if Customer.Get(Rec."No.") then
                        Error(CustomerAlreadyExistInsertErr, Rec."No.", Company.Name);
                    Customer := Rec;
                    Customer.Insert(true);
                end;
            until Company.Next() = 0;
    end;

    // Vendor - insert/modify/delete

    // Item - insert/modify/delete
    // Item UOM

    // GL Accounts - insert/modify/delete


    // Posting Groups / VAT/Tax Groups /  Inventory/Cust/Vendor - insert/modify/delete


    local procedure IsMasterCompany(): Boolean
    var
        CompanyInformation: Record "Company Information";
    begin
        if CompanyInformation.get() then
            exit(CompanyInformation."Master Company")
        else
            exit(false);

    end;

    var
        CustomerAlreadyExistInsertErr: Label 'Customer %1 already exists in Company %2', Comment = 'This error shows when a Master Customer is inserted, but exists in other companies.';
}