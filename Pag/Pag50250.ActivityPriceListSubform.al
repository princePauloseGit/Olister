namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Pricing.PriceList;

page 50250 "Activity Price List Subform"
{
    ApplicationArea = All;
    Caption = 'Activity Price List Subform';
    PageType = ListPart;
    SourceTable = "Price List Line";

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Asset Type"; Rec."Asset Type")
                {
                    ToolTip = 'Specifies the type of the product.';
                }
                field("Product No."; Rec."Product No.")
                {
                    ToolTip = 'Specifies the identifier of the product. If no product is selected, the price and discount values will apply to all products of the selected product type for which those values are not specified. For example, if you choose Item as the product type but do not specify a specific item, the price will apply to all items for which a price is not specified.';
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the product.';
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ToolTip = 'Specifies the item variant.';
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ToolTip = 'Specifies the price of one unit of the selected product.';
                    Visible = IsPurchase;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ToolTip = 'Specifies the direct unit cost of the product.';
                    Visible = IsPurchase;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ToolTip = 'Specifies the price of one unit of the selected product.';
                    Visible = IsSale;
                }
                field("Minimum Quantity"; Rec."Minimum Quantity")
                {
                    ToolTip = 'Specifies the minimum quantity of the product.';
                }
            }
        }
    }
    var
        IsSale: Boolean;
        IsPurchase: Boolean;





    trigger OnAfterGetRecord()
    begin
        Setvisibility();
    end;

    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Setvisibility();
    end;

    procedure Setvisibility()
    begin
        Clear(IsPurchase);
        Clear(IsSale);
        if Rec."Price Type" = Rec."Price Type"::Sale then
            IsSale := true
        else if Rec."Price Type" = Rec."Price Type"::Purchase then
            IsPurchase := true;
    end;
}
