// ------------------------------------------------------------------------------------------------
// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT License. See License.txt in the project root for license information.
// ------------------------------------------------------------------------------------------------
namespace Microsoft.Inventory.Item.Attribute;

using Microsoft.Inventory.Item;
using Microsoft.Inventory.Item.Catalog;

page 50223 "Product Attribute Value List"
{
    Caption = 'Product Attribute Values';
    DelayedInsert = true;
    LinksAllowed = false;
    PageType = ListPart;
    SourceTable = "Item Attribute Value Selection";
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Attribute Name"; Rec."Attribute Name")
                {
                    ApplicationArea = Basic, Suite;
                    AssistEdit = false;
                    Caption = 'Attribute';
                    TableRelation = "Item Attribute".Name where(Blocked = const(false));
                    ToolTip = 'Specifies the item attribute.';
                    trigger OnValidate()
                    var
                        ItemAttributeValue: Record "Item Attribute Value";
                        ItemAttribute: Record "Item Attribute";
                    begin
                        if xRec."Attribute Name" <> '' then begin
                            xRec.FindItemAttributeByName(ItemAttribute);
                            DeleteItemAttributeValueMapping(ItemAttribute.ID);
                        end;

                        if (Rec.Value <> '') and not Rec.FindAttributeValue(ItemAttributeValue) then
                            Rec.InsertItemAttributeValue(ItemAttributeValue, Rec);

                        InsertItemAttributeValueMapping(ItemAttributeValue);
                    end;
                }
                field(Value; Rec.Value)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Value';
                    TableRelation = if ("Attribute Type" = const(Option)) "Item Attribute Value".Value where("Attribute ID" = field("Attribute ID"),
                                                                                                            Blocked = const(false));
                    ToolTip = 'Specifies the value of the item attribute.';
                    trigger OnValidate()
                    var
                        ItemAttributeValue: Record "Item Attribute Value";
                        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                        ItemAttribute: Record "Item Attribute";
                    begin
                        if not Rec.FindAttributeValue(ItemAttributeValue) then
                            Rec.InsertItemAttributeValue(ItemAttributeValue, Rec);

                        InsertItemAttributeValueMapping(ItemAttributeValue);
                        ItemAttributeValueMapping.SetRange("Table ID", TableID);
                        ItemAttributeValueMapping.SetRange("No.", RelatedRecordCode);
                        ItemAttributeValueMapping.SetRange("Item Attribute ID", ItemAttributeValue."Attribute ID");
                        if ItemAttributeValueMapping.FindFirst() then begin
                            ItemAttributeValueMapping."Item Attribute Value ID" := ItemAttributeValue.ID;
                            ItemAttributeValueMapping.Modify();
                        end;

                        ItemAttribute.Get(Rec."Attribute ID");
                        if ItemAttribute.Type <> ItemAttribute.Type::Option then
                            if Rec.FindAttributeValueFromRecord(ItemAttributeValue, xRec) then
                                if not ItemAttributeValue.HasBeenUsed() then
                                    ItemAttributeValue.Delete();
                    end;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = Basic, Suite;
                    ToolTip = 'Specifies the name of the item or resource''s unit of measure, such as piece or hour.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnDeleteRecord(): Boolean
    begin
        DeleteItemAttributeValueMapping(Rec."Attribute ID");
    end;

    trigger OnOpenPage()
    begin
        CurrPage.Editable(true);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        myInt: Integer;
    begin

    end;



    protected var
        RelatedRecordCode: Code[20];
        TableID: Integer;

    //delete the attributes with No as: 'item'(used for temp page initialization)
    procedure DeleteTempAttributes(var attrS: Record "Item Attribute Value Selection"; ItemNo: code[20])
    var

        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        TempItemAttributeValue: Record "Item Attribute Value" temporary;
        ItemAttributeValue: Record "Item Attribute Value";
    begin
        ItemAttributeValueMapping.SetFilter("Table ID", '%1', TableID);
        ItemAttributeValueMapping.SetFilter("No.", '%1', ItemNo);
        if ItemAttributeValueMapping.FindSet() then
            ItemAttributeValueMapping.DeleteAll();
    end;

    //used when the item is to be saved
    procedure RenameAttributeItemNo(var attrS: Record "Item Attribute Value Selection"; ItemNo: code[20])
    var

        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        TempItemAttributeValue: Record "Item Attribute Value" temporary;
        ItemAttributeValue: Record "Item Attribute Value";
    begin
        ItemAttributeValueMapping.SetFilter("Table ID", '%1', TableID);
        ItemAttributeValueMapping.SetFilter("No.", 'ITEM');
        if ItemAttributeValueMapping.FindSet() then
            repeat
                ItemAttributeValueMapping.RenameItemAttributeValueMapping('ITEM', ItemNo);
            until ItemAttributeValueMapping.Next() = 0;

    end;

    procedure LoadAttributes(ItemNo: Code[20])
    var
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        TempItemAttributeValue: Record "Item Attribute Value" temporary;
        ItemAttributeValue: Record "Item Attribute Value";
    begin
        RelatedRecordCode := ItemNo;
        TableID := Database::Item;
        ItemAttributeValueMapping.SetRange("Table ID", TableID);
        ItemAttributeValueMapping.SetRange("No.", ItemNo);
        if ItemAttributeValueMapping.FindSet() then
            repeat
                ItemAttributeValue.Get(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID");
                TempItemAttributeValue.TransferFields(ItemAttributeValue);
                TempItemAttributeValue.Insert();
            until ItemAttributeValueMapping.Next() = 0;

        Rec.PopulateItemAttributeValueSelection(TempItemAttributeValue, TableID, ItemNo);
    end;

    procedure LoadAttributesFromCatalog(EntryNo: Code[20])
    var
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        TempItemAttributeValue: Record "Item Attribute Value" temporary;
        ItemAttributeValue: Record "Item Attribute Value";
    begin
        RelatedRecordCode := EntryNo;
        TableID := Database::"Nonstock Item";
        ItemAttributeValueMapping.SetRange("Table ID", TableID);
        ItemAttributeValueMapping.SetRange("No.", EntryNo);
        if ItemAttributeValueMapping.FindSet() then
            repeat
                ItemAttributeValue.Get(ItemAttributeValueMapping."Item Attribute ID", ItemAttributeValueMapping."Item Attribute Value ID");
                TempItemAttributeValue.TransferFields(ItemAttributeValue);
                TempItemAttributeValue.Insert();
            until ItemAttributeValueMapping.Next() = 0;

        Rec.PopulateItemAttributeValueSelection(TempItemAttributeValue, TableID, EntryNo);
    end;

    local procedure DeleteItemAttributeValueMapping(AttributeToDeleteID: Integer)
    var
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        ItemAttribute: Record "Item Attribute";
    begin
        ItemAttributeValueMapping.SetRange("Table ID", TableID);
        ItemAttributeValueMapping.SetRange("No.", RelatedRecordCode);
        ItemAttributeValueMapping.SetRange("Item Attribute ID", AttributeToDeleteID);
        if ItemAttributeValueMapping.FindFirst() then begin
            ItemAttributeValueMapping.Delete();
        end;

        ItemAttribute.Get(AttributeToDeleteID);
        ItemAttribute.RemoveUnusedArbitraryValues();
    end;

    local procedure InsertItemAttributeValueMapping(ItemAttributeValue: Record "Item Attribute Value")
    var
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
    begin
        if not ItemAttributeValue.Get(ItemAttributeValue."Attribute ID", ItemAttributeValue.ID) or
           ItemAttributeValueMapping.Get(TableID, RelatedRecordCode, ItemAttributeValue."Attribute ID") then
            exit;

        ItemAttributeValueMapping.Reset();
        ItemAttributeValueMapping.Init();
        ItemAttributeValueMapping."Table ID" := TableID;
        ItemAttributeValueMapping."No." := RelatedRecordCode;
        ItemAttributeValueMapping."Item Attribute ID" := ItemAttributeValue."Attribute ID";
        ItemAttributeValueMapping."Item Attribute Value ID" := ItemAttributeValue.ID;
        ItemAttributeValueMapping.Insert();
    end;




}

