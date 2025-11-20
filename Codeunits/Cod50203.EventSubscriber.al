
codeunit 50203 "Event Subscriber"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Catalog Item Management", 'OnCreateNewItemOnBeforeItemModify', '', false, false)]
    local procedure OnCreateNewItemOnBeforeItemModify(var Item: Record Item; NonstockItem: Record "Nonstock Item")
    var
        ItemAttributeValMapping: Record "Item Attribute Value Mapping";
        ItemAttributeValMapping2: Record "Item Attribute Value Mapping";
    begin
        Item."Product Category Code" := NonstockItem."Product Category Code";
        Item."Product Group Code" := NonstockItem."Product Group Code";
        Item."Product Type Code" := NonstockItem."Product Type Code";

        ItemAttributeValMapping.SetRange("Table ID", Database::"Nonstock Item");
        ItemAttributeValMapping.SetRange("No.", NonstockItem."Entry No.");

        if ItemAttributeValMapping.FindSet() then
            repeat
                if not ItemAttributeValMapping2.Get(Database::Item, Item."No.", ItemAttributeValMapping."Item Attribute ID") then begin
                    Clear(ItemAttributeValMapping2);
                    ItemAttributeValMapping2.Init();
                    ItemAttributeValMapping2."Table ID" := Database::Item;
                    ItemAttributeValMapping2."No." := Item."No.";
                    ItemAttributeValMapping2."Item Attribute ID" := ItemAttributeValMapping."Item Attribute ID";
                    ItemAttributeValMapping2."Item Attribute Value ID" := ItemAttributeValMapping."Item Attribute Value ID";
                    ItemAttributeValMapping2.Insert();
                end;
            until ItemAttributeValMapping.Next() = 0;
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnInsertReceiptLineOnAfterInitPurchRcptLine', '', false, false)]
    local procedure OnInsertReceiptLineOnAfterInitPurchRcptLine(var PurchRcptLine: Record "Purch. Rcpt. Line"; PurchLine: Record "Purchase Line"; ItemLedgShptEntryNo: Integer; xPurchLine: Record "Purchase Line"; var PurchRcptHeader: Record "Purch. Rcpt. Header"; var CostBaseAmount: Decimal; PostedWhseRcptHeader: Record "Posted Whse. Receipt Header"; WhseRcptHeader: Record "Warehouse Receipt Header"; var WhseRcptLine: Record "Warehouse Receipt Line")

    begin
        PurchRcptLine."Reason Code" := PurchLine."Reason Code";
        PurchRcptLine.Rejected := PurchLine.Rejected;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnPostItemJnlLineOnAfterCopyDocumentFields, '', false, false)]
    local procedure OnPostItemJnlLineOnAfterCopyDocumentFields(var ItemJournalLine: Record "Item Journal Line"; PurchaseLine: Record "Purchase Line"; WarehouseReceiptHeader: Record "Warehouse Receipt Header"; WarehouseShipmentHeader: Record "Warehouse Shipment Header"; PurchRcptHeader: Record "Purch. Rcpt. Header");
    begin
        ItemJournalLine.Rejected := PurchaseLine.Rejected;
        ItemJournalLine."Rejection Reason Code" := PurchaseLine."Reason Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", OnAfterInitItemLedgEntry, '', false, false)]
    local procedure OnAfterInitItemLedgEntry(var NewItemLedgEntry: Record "Item Ledger Entry"; var ItemJournalLine: Record "Item Journal Line"; var ItemLedgEntryNo: Integer);
    begin
        NewItemLedgEntry.Rejected := ItemJournalLine.Rejected;
        NewItemLedgEntry."Rejection Reason Code" := ItemJournalLine."Rejection Reason Code";
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", OnBeforePostPurchaseDoc, '', True, false)]
    local procedure OnBeforePostPurchaseDoc(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; CommitIsSupressed: Boolean; var HideProgressWindow: Boolean; var ItemJnlPostLine: Codeunit "Item Jnl.-Post Line"; var IsHandled: Boolean)
    var
        PurchLine: Record "Purchase Line";
    begin
        PurchLine.SetRange("Document Type", PurchaseHeader."Document Type"::Order);
        PurchLine.SetFilter("Document No.", PurchaseHeader."No.");
        PurchLine.SetRange(Rejected, true);
        PurchLine.SetFilter("Reason Code", '%1', '');
        if PurchLine.FindFirst() then
            Error('Cannot post Purchase Order with Rejected Items without Reason Code.');
    end;
}
