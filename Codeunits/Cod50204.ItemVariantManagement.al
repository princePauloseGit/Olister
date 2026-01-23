codeunit 50205 "Item Variant Management"
{
    procedure GenerateItemVariants(ItemNo: Code[20])
    var
        ConfirmMsg: Label 'This will generate item variants for all combinations of sizes, colors, and materials for Item %1. Continue?';
        SuccessMsg: Label '%1 item variant(s) created successfully.';
        VariantCount: Integer;
    begin
        if not Confirm(ConfirmMsg, false, ItemNo) then
            exit;

        VariantCount := GenerateItemVariantsSilent(ItemNo);

        if VariantCount > 0 then
            Message(SuccessMsg, VariantCount);
    end;

    procedure GenerateItemVariantsSilent(ItemNo: Code[20]): Integer
    var
        ItemSize: Record "Item Size";
        ItemColor: Record "Item Color";
        ItemMaterial: Record "Item Material";
        VariantCount: Integer;
    begin
        VariantCount := 0;

        // Get all sizes for this item
        ItemSize.SetRange("Item No.", ItemNo);
        if ItemSize.FindSet() then begin
            repeat
                // Get all colors for this item
                ItemColor.SetRange("Item No.", ItemNo);
                if ItemColor.FindSet() then begin
                    repeat
                        // Get all materials for this item
                        ItemMaterial.SetRange("Item No.", ItemNo);
                        if ItemMaterial.FindSet() then begin
                            repeat
                                CreateOrUpdateItemVariant(ItemNo, ItemSize."Size Code", ItemColor."Color Code", ItemMaterial."Material Code");
                                VariantCount += 1;
                            until ItemMaterial.Next() = 0;
                        end else begin
                            // Create variant without material
                            CreateOrUpdateItemVariant(ItemNo, ItemSize."Size Code", ItemColor."Color Code", '');
                            VariantCount += 1;
                        end;
                    until ItemColor.Next() = 0;
                end else begin
                    // Get all materials for this item (no colors)
                    ItemMaterial.SetRange("Item No.", ItemNo);
                    if ItemMaterial.FindSet() then begin
                        repeat
                            CreateOrUpdateItemVariant(ItemNo, ItemSize."Size Code", '', ItemMaterial."Material Code");
                            VariantCount += 1;
                        until ItemMaterial.Next() = 0;
                    end else begin
                        // Create variant with only size
                        CreateOrUpdateItemVariant(ItemNo, ItemSize."Size Code", '', '');
                        VariantCount += 1;
                    end;
                end;
            until ItemSize.Next() = 0;
        end else begin
            // No sizes, check colors
            ItemColor.SetRange("Item No.", ItemNo);
            if ItemColor.FindSet() then begin
                repeat
                    ItemMaterial.SetRange("Item No.", ItemNo);
                    if ItemMaterial.FindSet() then begin
                        repeat
                            CreateOrUpdateItemVariant(ItemNo, '', ItemColor."Color Code", ItemMaterial."Material Code");
                            VariantCount += 1;
                        until ItemMaterial.Next() = 0;
                    end else begin
                        CreateOrUpdateItemVariant(ItemNo, '', ItemColor."Color Code", '');
                        VariantCount += 1;
                    end;
                until ItemColor.Next() = 0;
            end else begin
                // No sizes or colors, check materials only
                ItemMaterial.SetRange("Item No.", ItemNo);
                if ItemMaterial.FindSet() then begin
                    repeat
                        CreateOrUpdateItemVariant(ItemNo, '', '', ItemMaterial."Material Code");
                        VariantCount += 1;
                    until ItemMaterial.Next() = 0;
                end;
            end;
        end;

        exit(VariantCount);
    end;

    local procedure CreateOrUpdateItemVariant(ItemNo: Code[20]; SizeCode: Code[20]; ColorCode: Code[20]; MaterialCode: Code[20])
    var
        ItemVariant: Record "Item Variant";
        VariantCode: Code[10];
        Description: Text[100];
    begin
        VariantCode := GenerateVariantCode(SizeCode, ColorCode, MaterialCode);
        Description := GenerateVariantDescription(SizeCode, ColorCode, MaterialCode);

        // Check if variant already exists
        if ItemVariant.Get(ItemNo, VariantCode) then begin
            // Update existing variant
            ItemVariant.Description := Description;
            ItemVariant.Validate("Size Code", SizeCode);
            ItemVariant.Validate("Color Code", ColorCode);
            ItemVariant.Validate("Material Code", MaterialCode);
            ItemVariant.Modify(true);
            exit;
        end;

        // Create new variant
        ItemVariant.Init();
        ItemVariant.Validate("Item No.", ItemNo);
        ItemVariant.Validate(Code, VariantCode);
        ItemVariant.Description := Description;
        ItemVariant.Validate("Size Code", SizeCode);
        ItemVariant.Validate("Color Code", ColorCode);
        ItemVariant.Validate("Material Code", MaterialCode);

        if not ItemVariant.Insert(true) then
            Error('Failed to create Item Variant. Variant Code: %1 for Item: %2', VariantCode, ItemNo);
    end;

    local procedure GenerateVariantCode(SizeCode: Code[20]; ColorCode: Code[20]; MaterialCode: Code[20]): Code[10]
    var
        VariantCode: Text;
    begin
        VariantCode := '';

        if SizeCode <> '' then
            VariantCode := SizeCode;

        if ColorCode <> '' then begin
            if VariantCode <> '' then
                VariantCode := VariantCode + '-';
            VariantCode := VariantCode + ColorCode;
        end;

        if MaterialCode <> '' then begin
            if VariantCode <> '' then
                VariantCode := VariantCode + '-';
            VariantCode := VariantCode + MaterialCode;
        end;

        exit(CopyStr(VariantCode, 1, 10));
    end;

    local procedure GenerateVariantDescription(SizeCode: Code[20]; ColorCode: Code[20]; MaterialCode: Code[20]): Text[100]
    var
        ItemSize: Record "Item Size";
        ItemColor: Record "Item Color";
        ItemMaterial: Record "Item Material";
        SizeRec: Record Sizes;
        ColorRec: Record Colors;
        MaterialRec: Record Materials;
        Description: Text;
    begin
        Description := '';

        if (SizeCode <> '') and SizeRec.Get(SizeCode) then begin
            Description := SizeRec.Description;
        end;

        if (ColorCode <> '') and ColorRec.Get(ColorCode) then begin
            if Description <> '' then
                Description := Description + ', ';
            Description := Description + ColorRec.Description;
        end;

        if (MaterialCode <> '') and MaterialRec.Get(MaterialCode) then begin
            if Description <> '' then
                Description := Description + ', ';
            Description := Description + MaterialRec.Description;
        end;

        exit(CopyStr(Description, 1, 100));
    end;
}
