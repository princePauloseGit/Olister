namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Item.Catalog;
using Microsoft.Inventory.Item.Attribute;

pageextension 50208 "Catalog Item Card Ext" extends "Catalog Item Card"
{
    layout
    {
        addlast(General)
        {
            field("Product Category Code"; Rec."Product Category Code")
            {
                ApplicationArea = all;
            }
            field("Product Group Code"; Rec."Product Group Code")
            {
                ApplicationArea = all;
            }
            field("Product Type Code"; Rec."Product Type Code")
            {
                ApplicationArea = all;
            }
        }
        addafter(Invoicing)
        {
            part("Item Attribute Value List"; "Product Attribute Value List")
            {
                ApplicationArea = all;
                //  SubPageLink = "Inherited-From Table ID" = filter(Database::"Nonstock Item"), "Inherited-From Key Value" = field("Entry No.");
            }
        }

    }
    trigger OnOpenPage()
    begin
        if Rec."Entry No." <> '' then
            CurrPage."Item Attribute Value List".PAGE.LoadAttributesFromCatalog(Rec."Entry No.");
    end;

}
