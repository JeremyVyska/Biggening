page 88001 "BCS Setup Overview"
{
    Caption = 'Setup Overview';
    PageType = ListPart;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = Company;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Name; Name)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Display Name"; "Display Name")
                {
                    ApplicationArea = All;
                }
                field(MasterCompany; MasterCompany)
                {
                    ApplicationArea = All;
                    Caption = 'Master Company';
                }
                field(GLAccount; SetupTableCounts[1])
                {
                    ApplicationArea = All;
                    Caption = 'G/L Account';
                }
                field(GenBusPosting; SetupTableCounts[2])
                {
                    ApplicationArea = All;
                    Caption = 'Gen. Bus. Posting';
                }

                field(GenProdPosting; SetupTableCounts[3])
                {
                    ApplicationArea = All;
                    Caption = 'Gen. Prod Posting';
                }

                field(GenPostingSetup; SetupTableCounts[4])
                {
                    ApplicationArea = All;
                    Caption = 'Gen. Posting Setups';
                }

                field(CustPostingGroups; SetupTableCounts[5])
                {
                    ApplicationArea = All;
                    Caption = 'Cust. Posting Groups';
                }

                field(CustDiscGroups; SetupTableCounts[6])
                {
                    ApplicationArea = All;
                    Caption = 'Cust. Disc. Groups';
                }

                field(PaymentTerms; SetupTableCounts[7])
                {
                    ApplicationArea = All;
                    Caption = 'Payment Terms';
                }

                field(VendPostingGroups; SetupTableCounts[8])
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Posting Groups';
                }

                field(InvPostingGroups; SetupTableCounts[9])
                {
                    ApplicationArea = All;
                    Caption = 'Inventory Posting Groups';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        GetSetupCounts(Rec.Name);
    end;

    local procedure IsMasterCompany(WhichCompany: Text[30])
    var
        CompanyInformation: Record "Company Information";
    begin
        MasterCompany := false;
        CompanyInformation.ChangeCompany(WhichCompany);
        if CompanyInformation.get() then
            MasterCompany := CompanyInformation."Master Company";
    end;

    local procedure GetSetupCounts(WhichCompany: Text[30])
    var
        GLAccount: Record "G/L Account";
        GenBusPosting: Record "Gen. Business Posting Group";
        GenProdPosting: Record "Gen. Product Posting Group";
        GenPostingSetup: Record "General Posting Setup";
        CustPostingGroups: Record "Customer Posting Group";
        CustDiscGroups: Record "Customer Discount Group";
        PaymentTerms: Record "Payment Method";
        VendPostingGroups: Record "Vendor Posting Group";
        InvPostingGroups: Record "Inventory Posting Group";
    begin
        Clear(SetupTableCounts);
        GLAccount.ChangeCompany(WhichCompany);
        SetupTableCounts[1] := GLAccount.Count;
        GenBusPosting.ChangeCompany(WhichCompany);
        SetupTableCounts[2] := GenBusPosting.Count;
        GenProdPosting.ChangeCompany(WhichCompany);
        SetupTableCounts[3] := GenProdPosting.Count;
        GenPostingSetup.ChangeCompany(WhichCompany);
        SetupTableCounts[4] := GenPostingSetup.Count;
        CustPostingGroups.ChangeCompany(WhichCompany);
        SetupTableCounts[5] := CustPostingGroups.Count;
        CustDiscGroups.ChangeCompany(WhichCompany);
        SetupTableCounts[6] := CustDiscGroups.Count;
        PaymentTerms.ChangeCompany(WhichCompany);
        SetupTableCounts[7] := PaymentTerms.Count;
        VendPostingGroups.ChangeCompany(WhichCompany);
        SetupTableCounts[8] := VendPostingGroups.Count;
        InvPostingGroups.ChangeCompany(WhichCompany);
        SetupTableCounts[9] := InvPostingGroups.Count;
    end;

    var
        SetupTableCounts: Array[9] of Integer;
        MasterCompany: Boolean;
}