page 50273 "Item Attr. Comb. Card"
{
    ApplicationArea = All;
    Caption = 'Item Attribute Combination';
    PageType = Card;
    SourceTable = "Item Attribute Combination";

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

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
                    ShowMandatory = true;
                }
                field("Item Description"; Rec."Item Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item description.';
                }
            }
            group(Attributes)
            {
                Caption = 'Attributes';

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
            }
            group(Variant)
            {
                Caption = 'Generated Variant';

                field("Item Variant Code"; Rec."Item Variant Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the generated item variant code.';
                    Editable = false;
                    Style = Strong;
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
        }
        area(Navigation)
        {
            action(ViewItemVariant)
            {
                ApplicationArea = All;
                Caption = 'View Item Variant';
                Image = ItemVariant;
                ToolTip = 'View the created item variant.';
                Promoted = true;
                PromotedCategory = Process;

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
                Promoted = true;
                PromotedCategory = Process;

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
