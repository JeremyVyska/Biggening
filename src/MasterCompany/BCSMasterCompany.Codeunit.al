codeunit 88000 "BCS Master Company"
{


    procedure CopySetupToCompany(WhichCompany: Text[30])
    var
        GLAccount: Record "G/L Account";
        GenBusPosting: Record "Gen. Business Posting Group";
        GenProdPosting: Record "Gen. Product Posting Group";
        GenPostingSetup: Record "General Posting Setup";
        CustPostingGroups: Record "Customer Posting Group";
        CustDiscGroups: Record "Customer Discount Group";
        PaymentTerms: Record "Payment Terms";
        PaymentMethods: Record "Payment Method";
        VendPostingGroups: Record "Vendor Posting Group";
        InvPostingGroups: Record "Inventory Posting Group";
        NoSeries: Record "No. Series";
        NoSeriesLine: Record "No. Series Line";
        SalesAndRecSetup: Record "Sales & Receivables Setup";
        PurchAndPaySetup: Record "Purchases & Payables Setup";
        InvtSetup: Record "Inventory Setup";
        DestGLAccount: Record "G/L Account";
        DestGenBusPosting: Record "Gen. Business Posting Group";
        DestGenProdPosting: Record "Gen. Product Posting Group";
        DestGenPostingSetup: Record "General Posting Setup";
        DestCustPostingGroups: Record "Customer Posting Group";
        DestCustDiscGroups: Record "Customer Discount Group";
        DestPaymentTerms: Record "Payment Terms";
        DestPaymentMethods: Record "Payment Method";
        DestVendPostingGroups: Record "Vendor Posting Group";
        DestInvPostingGroups: Record "Inventory Posting Group";
        DestNoSeries: Record "No. Series";
        DestNoSeriesLine: Record "No. Series Line";
        DestSalesAndRecSetup: Record "Sales & Receivables Setup";
        DestPurchAndPaySetup: Record "Purchases & Payables Setup";
        DestInvtSetup: Record "Inventory Setup";
        IsMasterCompany: Codeunit "BCS Is Master Company";
        DestGLAccountExists: Boolean;
        DestGenBusPostingExists: Boolean;
        DestGenProdPostingExists: Boolean;
        DestGenPostingSetupExists: Boolean;
        DestCustPostingGroupsExists: Boolean;
        DestCustDiscGroupsExists: Boolean;
        DestPaymentTermsExists: Boolean;
        DestPaymentMethodsExists: Boolean;
        DestVendPostingGroupsExists: Boolean;
        DestInvPostingGroupsExists: Boolean;
        DestNoSeriesExists: Boolean;
        DestNoSeriesLineExists: Boolean;
        DestSalesAndRecSetupExists: Boolean;
        DestPurchAndPaySetupExists: Boolean;
        DestInvtSetupExists: Boolean;
    begin
        if not IsMasterCompany.IsMC() then
            Error(CopySourceMustBeMasterErr, CompanyName());

        DestGLAccount.ChangeCompany(WhichCompany);
        DestGenBusPosting.ChangeCompany(WhichCompany);
        DestGenProdPosting.ChangeCompany(WhichCompany);
        DestGenPostingSetup.ChangeCompany(WhichCompany);
        DestCustPostingGroups.ChangeCompany(WhichCompany);
        DestCustDiscGroups.ChangeCompany(WhichCompany);
        DestPaymentTerms.ChangeCompany(WhichCompany);
        DestPaymentMethods.ChangeCompany(WhichCompany);
        DestVendPostingGroups.ChangeCompany(WhichCompany);
        DestInvPostingGroups.ChangeCompany(WhichCompany);
        DestNoSeries.ChangeCompany(WhichCompany);
        DestNoSeriesLine.ChangeCompany(WhichCompany);
        DestSalesAndRecSetup.ChangeCompany(WhichCompany);
        DestPurchAndPaySetup.ChangeCompany(WhichCompany);
        DestInvtSetup.ChangeCompany(WhichCompany);

        if GLAccount.FindSet(false) then
            repeat
                DestGLAccountExists := DestGLAccount.Get(GLAccount."No.");
                DestGLAccount.TransferFields(GLAccount, not DestGLAccountExists);
                if DestGLAccountExists then
                    DestGLAccount.Modify()
                else
                    DestGLAccount.Insert();
            until GLAccount.Next() = 0;

        if GenBusPosting.FindSet(false) then
            repeat
                DestGenBusPostingExists := DestGenBusPosting.Get(GenBusPosting."Code");
                DestGenBusPosting.TransferFields(GenBusPosting, not DestGenBusPostingExists);
                if DestGenBusPostingExists then
                    DestGenBusPosting.Modify()
                else
                    DestGenBusPosting.Insert();
            until GenBusPosting.Next() = 0;

        if GenProdPosting.FindSet(false) then
            repeat
                DestGenProdPostingExists := DestGenProdPosting.Get(GenProdPosting."Code");
                DestGenProdPosting.TransferFields(GenProdPosting, not DestGenProdPostingExists);
                if DestGenProdPostingExists then
                    DestGenProdPosting.Modify()
                else
                    DestGenProdPosting.Insert();
            until GenProdPosting.Next() = 0;

        if GenPostingSetup.FindSet(false) then
            repeat
                DestGenPostingSetupExists := DestGenPostingSetup.Get(GenPostingSetup."Gen. Bus. Posting Group", GenPostingSetup."Gen. Prod. Posting Group");
                DestGenPostingSetup.TransferFields(GenPostingSetup, not DestGenPostingSetupExists);
                if DestGenPostingSetupExists then
                    DestGenPostingSetup.Modify()
                else
                    DestGenPostingSetup.Insert();
            until GenPostingSetup.Next() = 0;

        if CustPostingGroups.FindSet(false) then
            repeat
                DestCustPostingGroupsExists := DestCustPostingGroups.Get(CustPostingGroups."Code");
                DestCustPostingGroups.TransferFields(CustPostingGroups, not DestCustPostingGroupsExists);
                if DestCustPostingGroupsExists then
                    DestCustPostingGroups.Modify()
                else
                    DestCustPostingGroups.Insert();
            until CustPostingGroups.Next() = 0;

        if CustDiscGroups.FindSet(false) then
            repeat
                DestCustDiscGroupsExists := DestCustDiscGroups.Get(CustDiscGroups."Code");
                DestCustDiscGroups.TransferFields(CustDiscGroups, not DestCustDiscGroupsExists);
                if DestCustDiscGroupsExists then
                    DestCustDiscGroups.Modify()
                else
                    DestCustDiscGroups.Insert();
            until CustDiscGroups.Next() = 0;

        if PaymentTerms.FindSet(false) then
            repeat
                DestPaymentTermsExists := DestPaymentTerms.Get(PaymentTerms."Code");
                DestPaymentTerms.TransferFields(PaymentTerms, not DestPaymentTermsExists);
                if DestPaymentTermsExists then
                    DestPaymentTerms.Modify()
                else
                    DestPaymentTerms.Insert();
            until PaymentTerms.Next() = 0;

        if PaymentMethods.FindSet(false) then
            repeat
                DestPaymentMethodsExists := DestPaymentMethods.Get(PaymentMethods."Code");
                DestPaymentMethods.TransferFields(PaymentMethods, not DestPaymentMethodsExists);
                if DestPaymentMethodsExists then
                    DestPaymentMethods.Modify()
                else
                    DestPaymentMethods.Insert();
            until PaymentMethods.Next() = 0;

        if VendPostingGroups.FindSet(false) then
            repeat
                DestVendPostingGroupsExists := DestVendPostingGroups.Get(VendPostingGroups."Code");
                DestVendPostingGroups.TransferFields(VendPostingGroups, not DestVendPostingGroupsExists);
                if DestVendPostingGroupsExists then
                    DestVendPostingGroups.Modify()
                else
                    DestVendPostingGroups.Insert();
            until VendPostingGroups.Next() = 0;

        if InvPostingGroups.FindSet(false) then
            repeat
                DestInvPostingGroupsExists := DestInvPostingGroups.Get(InvPostingGroups."Code");
                DestInvPostingGroups.TransferFields(InvPostingGroups, not DestInvPostingGroupsExists);
                if DestInvPostingGroupsExists then
                    DestInvPostingGroups.Modify()
                else
                    DestInvPostingGroups.Insert();
            until InvPostingGroups.Next() = 0;

        if NoSeries.FindSet(false) then
            repeat
                DestNoSeriesExists := DestNoSeries.Get(NoSeries."Code");
                DestNoSeries.TransferFields(NoSeries, not DestNoSeriesExists);
                if DestNoSeriesExists then
                    DestNoSeries.Modify()
                else
                    DestNoSeries.Insert();
            until NoSeries.Next() = 0;

        if NoSeriesLine.FindSet(false) then
            repeat
                DestNoSeriesLineExists := DestNoSeriesLine.Get(NoSeriesLine."Series Code", NoSeriesLine."Line No.");
                DestNoSeriesLine.TransferFields(NoSeriesLine, not DestNoSeriesLineExists);
                if DestNoSeriesLineExists then
                    DestNoSeriesLine.Modify()
                else
                    DestNoSeriesLine.Insert();
            until NoSeriesLine.Next() = 0;

        if SalesAndRecSetup.FindSet(false) then
            repeat
                DestSalesAndRecSetupExists := DestSalesAndRecSetup.Get(SalesAndRecSetup."Primary Key");
                DestSalesAndRecSetup.TransferFields(SalesAndRecSetup, not DestSalesAndRecSetupExists);
                if DestSalesAndRecSetupExists then
                    DestSalesAndRecSetup.Modify()
                else
                    DestSalesAndRecSetup.Insert();
            until SalesAndRecSetup.Next() = 0;

        if PurchAndPaySetup.FindSet(false) then
            repeat
                DestPurchAndPaySetupExists := DestPurchAndPaySetup.Get(PurchAndPaySetup."Primary Key");
                DestPurchAndPaySetup.TransferFields(PurchAndPaySetup, not DestPurchAndPaySetupExists);
                if DestPurchAndPaySetupExists then
                    DestPurchAndPaySetup.Modify()
                else
                    DestPurchAndPaySetup.Insert();
            until PurchAndPaySetup.Next() = 0;

        if InvtSetup.FindSet(false) then
            repeat
                DestInvtSetupExists := DestInvtSetup.Get(InvtSetup."Primary Key");
                DestInvtSetup.TransferFields(InvtSetup, not DestInvtSetupExists);
                if DestInvtSetupExists then
                    DestInvtSetup.Modify()
                else
                    DestInvtSetup.Insert();
            until InvtSetup.Next() = 0;
    end;



    var
        CopySourceMustBeMasterErr: Label 'Company %1 is not marked as a Master company, so cannot be used as a source.';
}