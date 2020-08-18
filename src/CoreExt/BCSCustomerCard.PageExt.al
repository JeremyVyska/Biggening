pageextension 88007 "BCS Customer Card" extends "Customer Card"
{
    actions
    {
        addlast("Prices and Discounts")
        {
            action(ItemCatalog)
            {
                Caption = 'Item Catalog';
                Image = ItemLines;
                RunObject = Page "BCS Item Customer Catalog";
                RunPageLink = "Customer No." = field("No.");
            }
        }
    }

}