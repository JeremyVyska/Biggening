page 88016 "BCS Prospect List"
{
    ApplicationArea = All;
    Caption = 'BCS Prospect List';
    PageType = List;
    SourceTable = "BCS Prospect";
    UsageCategory = Lists;
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Name; Name)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field("Maximum Orders Per Day"; "Maximum Orders Per Day")
                {
                    ApplicationArea = All;
                }
                field("Maximum Quantity Per Order"; "Maximum Quantity Per Order")
                {
                    ApplicationArea = All;
                }
            }
        }

        area(FactBoxes)
        {
            part(Trades; "BCS Prospect Trade Factbox")
            {
                SubPageLink = "Prospect No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ConvertToVend)
            {
                Caption = 'Make Vendor';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Vendor;
                Enabled = Type = Type::Vendor;

                trigger OnAction()
                var
                    Vendor: Record Vendor;
                    VendorNo: Code[20];
                begin
                    VendorNo := Rec.ConvertToVendor();
                    Rec.Delete(true);
                    Vendor.Get(VendorNo);
                    Vendor.SetRecFilter();
                    Page.Run(0, Vendor);
                end;
            }

            action(ConvertToCust)
            {
                Caption = 'Make Customer';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Customer;
                Enabled = Type = Type::Customer;

                trigger OnAction()
                var
                    Customer: Record Customer;
                    CustomerNo: Code[20];
                begin
                    CustomerNo := Rec.ConvertToCustomer();
                    Rec.Delete(true);
                    Customer.Get(CustomerNo);
                    Customer.SetRecFilter();
                    Page.Run(0, Customer);
                end;
            }
        }
    }

}
