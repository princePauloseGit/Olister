page 50248 "Item Attribute Combinations"
{
    ApplicationArea = All;
    Caption = 'Item Attribute Combinations';
    PageType = List;
    SourceTable = "Item Attribute Combination";
    UsageCategory = Lists;
    CardPageId = "Item Attr. Comb. Card";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                    Editable = false;
                }
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item number.';
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item description.';
                }
                field("Size Code"; Rec."Size Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size code.';
                }
                field("Size Description"; Rec."Size Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size description.';
                }
                field("Color Code"; Rec."Color Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the color code.';
                }
                field("Color Description"; Rec."Color Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the color description.';
                }
                field("Material Code"; Rec."Material Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the material code.';
                }
                field("Material Description"; Rec."Material Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the material description.';
                }
                field("Item Variant Code"; Rec."Item Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the generated item variant code.';
                    Editable = false;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(SyncToVariant)
            {
                ApplicationArea = All;
                Caption = 'Sync to Variant';
                Image = Refresh;
                ToolTip = 'Create or update the item variant with the current attribute combination.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ItemVariant: Record "Item Variant";
                    VariantCode: Code[10];
                    ItemAttrComb: Record "Item Attribute Combination";
                begin
                    if Rec."Item No." = '' then
                        Error('Item No. must be specified.');

                    ItemAttrComb := Rec;
                    VariantCode := ItemAttrComb.GenerateVariantCode();

                    // Check if variant already exists
                    if ItemVariant.Get(Rec."Item No.", VariantCode) then begin
                        // Update existing variant
                        ItemVariant.Validate("Size Code", Rec."Size Code");
                        ItemVariant.Validate("Color Code", Rec."Color Code");
                        ItemVariant.Validate("Material Code", Rec."Material Code");
                        ItemVariant.Modify(true);
                        Message('Item Variant %1 has been updated successfully.', VariantCode);
                    end else begin
                        // Create new variant
                        ItemVariant.Init();
                        ItemVariant.Validate("Item No.", Rec."Item No.");
                        ItemVariant.Validate(Code, VariantCode);
                        ItemVariant.Description := ItemAttrComb.GenerateVariantDescription();
                        ItemVariant.Validate("Size Code", Rec."Size Code");
                        ItemVariant.Validate("Color Code", Rec."Color Code");
                        ItemVariant.Validate("Material Code", Rec."Material Code");
                        ItemVariant.Insert(true);
                        Message('Item Variant %1 has been created successfully.', VariantCode);
                    end;

                    // Update the Item Variant Code field
                    if Rec."Item Variant Code" <> VariantCode then begin
                        Rec."Item Variant Code" := VariantCode;
                        Rec.Modify(false);
                    end;
                end;
            }
            action(SyncAllToVariants)
            {
                ApplicationArea = All;
                Caption = 'Sync All to Variants';
                Image = RefreshLines;
                ToolTip = 'Create or update item variants for all attribute combinations in the list.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    ItemAttrComb: Record "Item Attribute Combination";
                    ItemVariant: Record "Item Variant";
                    VariantCode: Code[10];
                    TotalCount: Integer;
                    CreatedCount: Integer;
                    UpdatedCount: Integer;
                    ErrorCount: Integer;
                    ProgressDialog: Dialog;
                begin
                    if not Confirm('Do you want to sync all attribute combinations to item variants?', false) then
                        exit;

                    ItemAttrComb.Copy(Rec);
                    ItemAttrComb.SetCurrentKey("Entry No.");

                    if not ItemAttrComb.FindSet() then begin
                        Message('No records found to sync.');
                        exit;
                    end;

                    TotalCount := ItemAttrComb.Count;
                    ProgressDialog.Open('Syncing attribute combinations...\Processing #1####### of #2#######\Created: #3#####\Updated: #4#####\Errors: #5#####');

                    repeat
                        ProgressDialog.Update(1, ItemAttrComb."Entry No.");
                        ProgressDialog.Update(2, TotalCount);
                        ProgressDialog.Update(3, CreatedCount);
                        ProgressDialog.Update(4, UpdatedCount);
                        ProgressDialog.Update(5, ErrorCount);

                        if ItemAttrComb."Item No." <> '' then begin
                            VariantCode := ItemAttrComb.GenerateVariantCode();

                            // Check if variant already exists
                            if ItemVariant.Get(ItemAttrComb."Item No.", VariantCode) then begin
                                // Update existing variant
                                ItemVariant.Validate("Size Code", ItemAttrComb."Size Code");
                                ItemVariant.Validate("Color Code", ItemAttrComb."Color Code");
                                ItemVariant.Validate("Material Code", ItemAttrComb."Material Code");
                                if ItemVariant.Modify(true) then
                                    UpdatedCount += 1
                                else
                                    ErrorCount += 1;
                            end else begin
                                // Create new variant
                                Clear(ItemVariant);
                                ItemVariant.Init();
                                ItemVariant.Validate("Item No.", ItemAttrComb."Item No.");
                                ItemVariant.Validate(Code, VariantCode);
                                ItemVariant.Description := ItemAttrComb.GenerateVariantDescription();
                                ItemVariant.Validate("Size Code", ItemAttrComb."Size Code");
                                ItemVariant.Validate("Color Code", ItemAttrComb."Color Code");
                                ItemVariant.Validate("Material Code", ItemAttrComb."Material Code");
                                if ItemVariant.Insert(true) then
                                    CreatedCount += 1
                                else
                                    ErrorCount += 1;
                            end;

                            // Update the Item Variant Code field
                            if ItemAttrComb."Item Variant Code" <> VariantCode then begin
                                ItemAttrComb."Item Variant Code" := VariantCode;
                                ItemAttrComb.Modify(false);
                            end;
                        end;
                    until ItemAttrComb.Next() = 0;

                    ProgressDialog.Close();

                    Message('Sync completed.\Created: %1\Updated: %2\Errors: %3\Total: %4',
                            CreatedCount, UpdatedCount, ErrorCount, TotalCount);

                    CurrPage.Update(false);
                end;
            }
        }
        area(Navigation)
        {
            action(ViewItemVariant)
            {
                ApplicationArea = All;
                Caption = 'View Item Variant';
                Image = ItemVariant;
                ToolTip = 'View the created item variant.';

                trigger OnAction()
                var
                    ItemVariant: Record "Item Variant";
                begin
                    if Rec."Item Variant Code" <> '' then begin
                        ItemVariant.Get(Rec."Item No.", Rec."Item Variant Code");
                        Page.Run(Page::"Item Variant Card", ItemVariant);
                    end else
                        Message('No variant has been created yet.');
                end;
            }
            action(ViewItem)
            {
                ApplicationArea = All;
                Caption = 'View Item';
                Image = Item;
                ToolTip = 'View the item card.';

                trigger OnAction()
                var
                    Item: Record Item;
                begin
                    if Rec."Item No." <> '' then begin
                        Item.Get(Rec."Item No.");
                        Page.Run(Page::"Item Card", Item);
                    end;
                end;
            }
        }
    }
}
