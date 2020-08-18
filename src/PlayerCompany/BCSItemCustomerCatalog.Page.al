page 88023 "BCS Item Customer Catalog"
{
    Caption = 'Item Customer Catalog';
    DataCaptionFields = "Item No.";
    PageType = List;
    SourceTable = "BCS Item Customer";

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Item No."; "Item No.")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the number of the item the customer is willing to Salesase.';
                    Visible = false;
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the variant of the item on the line.';
                    Visible = false;
                }
                field("Customer No."; "Customer No.")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the number of the Customer is willing to Salesase this Item.';
                }
                field("Customer Item No."; "Customer Item No.")
                {
                    ApplicationArea = Planning;
                    ToolTip = 'Specifies the number that the Customer uses for this item.';
                }
            }
        }
        area(factboxes)
        {
            systempart(Control1900383207; Links)
            {
                ApplicationArea = RecordLinks;
                Visible = false;
            }
            systempart(Control1905767507; Notes)
            {
                ApplicationArea = Notes;
                Visible = false;
            }
        }
    }


}
