namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Pricing.PriceList;
using Microsoft.Projects.Project.Job;
using Microsoft.Purchases.Document;
using Microsoft.Projects.Project.Planning;

page 50234 "Price List Line Selection"
{
    ApplicationArea = All;
    Caption = 'Price List Line Selection';
    PageType = List;
    SourceTable = "Price List Line";
    Editable = false;
    //UsageCategory = None;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Assign-to No."; Rec."Assign-to No.")
                {
                    ToolTip = 'Specifies the entity to which the prices are assigned. The options depend on the selection in the Assign-to Type field. If you choose an entity, the price list will be used only for that entity.';
                }
                field("Product No."; Rec."Product No.")
                {
                    ToolTip = 'Specifies the identifier of the product. If no product is selected, the price and discount values will apply to all products of the selected product type for which those values are not specified. For example, if you choose Item as the product type but do not specify a specific item, the price will apply to all items for which a price is not specified.';
                }
                field("Unit Price"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the price of one unit of the selected product.';
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the unit of measure for the product.';
                }
            }
        }
    }
}
