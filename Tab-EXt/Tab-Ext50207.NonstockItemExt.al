namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Item.Catalog;

tableextension 50207 "Nonstock Item Ext" extends "Nonstock Item"
{
    fields
    {
        field(50200; "Product Type Code"; Code[20])
        {
            Caption = 'Product Type';
            DataClassification = CustomerContent;
            TableRelation = "Product Type";
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                ProductMgt: Codeunit "Product Hierarchy Mgt";
            begin
                ProductMgt.EnsureProductType("Product Type Code");
            end;
        }
        field(50201; "Product Category Code"; Code[20])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
            TableRelation = "Product Category"."Product Category Code"
                WHERE("Product Type Code" = FIELD("Product Type Code"));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                ProductMgt: Codeunit "Product Hierarchy Mgt";
            begin
                ProductMgt.EnsureProductCategory("Product Category Code", "Product Type Code");
            end;

        }
        field(50202; "Product Group Code"; Code[20])
        {
            Caption = 'Group';
            DataClassification = CustomerContent;
            TableRelation = "Product Group"."Product Group Code"
                WHERE("Product Category Code" = FIELD("Product Category Code"));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                ProductMgt: Codeunit "Product Hierarchy Mgt";
            begin
                ProductMgt.EnsureProductGroup("Product Group Code", "Product Category Code");
            end;

        }
    }
}
