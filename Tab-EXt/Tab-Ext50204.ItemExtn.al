namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Item;
using Microsoft.Purchases.History;
using Microsoft.Projects.Project.Job;
using Microsoft.Purchases.Document;
using Microsoft.Inventory.Item.Attribute;
using Microsoft.Sales.Document;
using Microsoft.Sales.History;

tableextension 50204 ItemExtn extends Item
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
        field(50203; "Core Product"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50204; "Brochure"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50205; "Archive Products"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50206; "CG Website"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50207; "Prokyt Website"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50208; "Prokyt Cato"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(50209; "Cost"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(50210; "Trade"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(50211; "MAP"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(50212; "RRP"; Code[30])
        {
            DataClassification = CustomerContent;
        }
        field(50213; "Qty. on Purch. Quote"; Decimal)
        {
            AccessByPermission = TableData "Purch. Rcpt. Header" = R;
            CalcFormula = sum("Purchase Line"."Outstanding Qty. (Base)" where("Document Type" = const(Quote),
                                                                               Type = const(Item),
                                                                               "No." = field("No."),
                                                                               "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                               "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                               "Location Code" = field("Location Filter"),
                                                                               "Drop Shipment" = field("Drop Shipment Filter"),
                                                                               "Variant Code" = field("Variant Filter"),
                                                                               "Expected Receipt Date" = field("Date Filter"),
                                                                               "Unit of Measure Code" = field("Unit of Measure Filter")));
            Caption = 'Qty. on Purch. Quote';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50214; "Qty. on Sales Quote"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = sum("Sales Line"."Outstanding Qty. (Base)" where("Document Type" = const(Quote),
                                                                            Type = const(Item),
                                                                            "No." = field("No."),
                                                                            "Shortcut Dimension 1 Code" = field("Global Dimension 1 Filter"),
                                                                            "Shortcut Dimension 2 Code" = field("Global Dimension 2 Filter"),
                                                                            "Location Code" = field("Location Filter"),
                                                                            "Drop Shipment" = field("Drop Shipment Filter"),
                                                                            "Variant Code" = field("Variant Filter"),
                                                                            "Shipment Date" = field("Date Filter"),
                                                                            "Unit of Measure Code" = field("Unit of Measure Filter")));
            Caption = 'Qty. on Sales Quote';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(50215; "Previous Version"; Code[20])
        {
            Caption = 'Previous Version';
            DataClassification = CustomerContent;
            TableRelation = Item."No.";
            trigger OnValidate()
            begin
                UpdateItemversionMaster();
                CopyAttriburesfromPreviousVersion();
            end;
        }
        field(50216; "Next Version"; Code[20])
        {
            Caption = 'Next Version';
            DataClassification = CustomerContent;
            // TableRelation = Item."No.";
        }
        field(50217; "Live Projects"; Integer)
        {
            Caption = 'Live Projects';
            CalcFormula = count(Job where("Item No" = field("No."),
                                         "Status" = const(Open)));
            FieldClass = FlowField;
        }
        field(50218; "All Projects"; Integer)
        {
            Caption = 'All Projects';
            CalcFormula = count(Job where("Item No" = field("No.")));
            FieldClass = FlowField;
        }
    }
    procedure UpdateItemversionMaster()
    var
        ItemVerionMast: Record "Item Version Master";
        Item: Record Item;
    begin
        if Item.Get("Previous Version") then begin
            ItemVerionMast.Init();
            ItemVerionMast."Item No." := "No.";
            ItemVerionMast."Previous Version" := "Previous Version";
            ItemVerionMast.Insert();
        end else
            Error('Invalid Item No. %1', "Previous Version");
    end;

    procedure CopyAttriburesfromPreviousVersion()
    var
        Item: Record Item;
        ItemAttributeValMapping: Record "Item Attribute Value Mapping";
        ItemAttributeValMapping2: Record "Item Attribute Value Mapping";

    begin
        ItemAttributeValMapping.SetRange("Table ID", Database::Item);
        ItemAttributeValMapping.SetFilter("No.", "Previous Version");
        if ItemAttributeValMapping.FindSet() then
            repeat
                if ItemAttributeValMapping2.Get(Database::Item, "No.", ItemAttributeValMapping."Item Attribute ID") then begin
                    ItemAttributeValMapping2."Item Attribute Value ID" := ItemAttributeValMapping."Item Attribute Value ID";
                    ItemAttributeValMapping2.Modify();
                end
                else begin
                    Clear(ItemAttributeValMapping2);
                    ItemAttributeValMapping2.Init();
                    ItemAttributeValMapping2."Table ID" := Database::Item;
                    ItemAttributeValMapping2."No." := "No.";
                    ItemAttributeValMapping2."Item Attribute ID" := ItemAttributeValMapping."Item Attribute ID";
                    ItemAttributeValMapping2."Item Attribute Value ID" := ItemAttributeValMapping."Item Attribute Value ID";
                    ItemAttributeValMapping2.Insert();
                end;
            until ItemAttributeValMapping.Next() = 0;

    end;
}
