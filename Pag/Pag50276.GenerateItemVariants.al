page 50276 "Generate Item Variants"
{
    ApplicationArea = All;
    Caption = 'Generate Item Variants';
    PageType = List;
    SourceTable = Item;
    UsageCategory = Lists;
    CardPageId = "Item Card";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Items)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item number.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item description.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item type.';
                }
                field(SizesCount; GetSizesCount())
                {
                    ApplicationArea = All;
                    Caption = 'Sizes';
                    ToolTip = 'Shows the number of sizes defined for this item.';
                    Style = Strong;
                }
                field(ColorsCount; GetColorsCount())
                {
                    ApplicationArea = All;
                    Caption = 'Colors';
                    ToolTip = 'Shows the number of colors defined for this item.';
                    Style = Strong;
                }
                field(MaterialsCount; GetMaterialsCount())
                {
                    ApplicationArea = All;
                    Caption = 'Materials';
                    ToolTip = 'Shows the number of materials defined for this item.';
                    Style = Strong;
                }
                field(TotalCombinations; CalculateTotalCombinations())
                {
                    ApplicationArea = All;
                    Caption = 'Total Combinations';
                    ToolTip = 'Shows the total number of variant combinations that will be created.';
                    Style = StrongAccent;
                }
            }
        }
        area(FactBoxes)
        {
            part(AttributesSummary; "Item Picture")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ManageSizes)
            {
                ApplicationArea = All;
                Caption = 'Manage Item Sizes';
                Image = Dimensions;
                ToolTip = 'Manage sizes for the selected item.';

                trigger OnAction()
                var
                    ItemSize: Record "Item Size";
                    ItemSizesPage: Page "Item Sizes";
                begin
                    ItemSize.SetRange("Item No.", Rec."No.");
                    ItemSizesPage.SetTableView(ItemSize);
                    ItemSizesPage.RunModal();
                    CurrPage.Update(false);
                end;
            }
            action(ManageColors)
            {
                ApplicationArea = All;
                Caption = 'Manage Item Colors';
                Image = ItemGroup;
                ToolTip = 'Manage colors for the selected item.';

                trigger OnAction()
                var
                    ItemColor: Record "Item Color";
                    ItemColorsPage: Page "Item Colors";
                begin
                    ItemColor.SetRange("Item No.", Rec."No.");
                    ItemColorsPage.SetTableView(ItemColor);
                    ItemColorsPage.RunModal();
                    CurrPage.Update(false);
                end;
            }
            action(ManageMaterials)
            {
                ApplicationArea = All;
                Caption = 'Manage Item Materials';
                Image = Production;
                ToolTip = 'Manage materials for the selected item.';

                trigger OnAction()
                var
                    ItemMaterial: Record "Item Material";
                    ItemMaterialsPage: Page "Item Materials";
                begin
                    ItemMaterial.SetRange("Item No.", Rec."No.");
                    ItemMaterialsPage.SetTableView(ItemMaterial);
                    ItemMaterialsPage.RunModal();
                    CurrPage.Update(false);
                end;
            }
            action(GenerateVariants)
            {
                ApplicationArea = All;
                Caption = 'Generate Variants for Selected Item';
                Image = CreateDocument;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Generate all item variant combinations for the selected item based on sizes, colors, and materials.';

                trigger OnAction()
                var
                    ItemVariantMgt: Codeunit "Item Variant Management";
                begin
                    ItemVariantMgt.GenerateItemVariants(Rec."No.");
                    CurrPage.Update(false);
                end;
            }
            action(GenerateForSelectedItems)
            {
                ApplicationArea = All;
                Caption = 'Generate Variants for Multiple Items';
                Image = CreateDocuments;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Generate item variant combinations for multiple selected items.';

                trigger OnAction()
                begin
                    GenerateVariantsForSelectedItems();
                end;
            }
            action(GenerateForAllItems)
            {
                ApplicationArea = All;
                Caption = 'Generate Variants for All Items';
                Image = CreateJobSalesInvoice;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ToolTip = 'Generate item variant combinations for all items that have sizes, colors, or materials defined.';

                trigger OnAction()
                begin
                    GenerateVariantsForAllItems();
                end;
            }
            action(ShowItemsWithAttributes)
            {
                ApplicationArea = All;
                Caption = 'Show Items with Attributes';
                Image = FilterLines;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Filter to show only items that have sizes, colors, or materials defined.';

                trigger OnAction()
                begin
                    FilterItemsWithAttributes();
                end;
            }
            action(ShowAllItems)
            {
                ApplicationArea = All;
                Caption = 'Show All Items';
                Image = ClearFilter;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Clear filters and show all items.';

                trigger OnAction()
                begin
                    Rec.Reset();
                    CurrPage.Update(false);
                end;
            }
        }
        area(Navigation)
        {
            action(ItemCard)
            {
                ApplicationArea = All;
                Caption = 'Item Card';
                Image = Item;
                RunObject = page "Item Card";
                RunPageLink = "No." = field("No.");
                ToolTip = 'Open the item card for the selected item.';
            }
            action(ItemVariants)
            {
                ApplicationArea = All;
                Caption = 'Item Variants';
                Image = ItemVariant;
                RunObject = page "Item Variants";
                RunPageLink = "Item No." = field("No.");
                ToolTip = 'View existing item variants for the selected item.';
            }
        }
    }

    local procedure GetSizesCount(): Integer
    var
        ItemSize: Record "Item Size";
    begin
        ItemSize.SetRange("Item No.", Rec."No.");
        exit(ItemSize.Count);
    end;

    local procedure GetColorsCount(): Integer
    var
        ItemColor: Record "Item Color";
    begin
        ItemColor.SetRange("Item No.", Rec."No.");
        exit(ItemColor.Count);
    end;

    local procedure GetMaterialsCount(): Integer
    var
        ItemMaterial: Record "Item Material";
    begin
        ItemMaterial.SetRange("Item No.", Rec."No.");
        exit(ItemMaterial.Count);
    end;

    local procedure CalculateTotalCombinations(): Integer
    var
        SizeCount: Integer;
        ColorCount: Integer;
        MaterialCount: Integer;
    begin
        SizeCount := GetSizesCount();
        ColorCount := GetColorsCount();
        MaterialCount := GetMaterialsCount();

        if (SizeCount = 0) and (ColorCount = 0) and (MaterialCount = 0) then
            exit(0);

        // If at least one attribute exists, treat missing attributes as 1
        if SizeCount = 0 then
            SizeCount := 1;
        if ColorCount = 0 then
            ColorCount := 1;
        if MaterialCount = 0 then
            MaterialCount := 1;

        exit(SizeCount * ColorCount * MaterialCount);
    end;

    local procedure GenerateVariantsForSelectedItems()
    var
        Item: Record Item;
        ItemVariantMgt: Codeunit "Item Variant Management";
        ConfirmMsg: Label 'This will generate item variants for all selected items. Continue?';
        SuccessMsg: Label 'Variants generated successfully for %1 item(s). Total variants created: %2.';
        Window: Dialog;
        ItemsProcessed: Integer;
        TotalItems: Integer;
        TotalVariants: Integer;
        VariantCount: Integer;
    begin
        CurrPage.SetSelectionFilter(Item);
        TotalItems := Item.Count();

        if TotalItems = 0 then begin
            Message('No items selected. Please select one or more items.');
            exit;
        end;

        if not Confirm(ConfirmMsg, false) then
            exit;

        Window.Open('Generating Item Variants...\\Processing item #1#### of #2#### : #3########');

        ItemsProcessed := 0;
        TotalVariants := 0;
        if Item.FindSet() then
            repeat
                ItemsProcessed += 1;
                Window.Update(1, ItemsProcessed);
                Window.Update(2, TotalItems);
                Window.Update(3, Item.Description);
                VariantCount := ItemVariantMgt.GenerateItemVariantsSilent(Item."No.");
                TotalVariants += VariantCount;
            until Item.Next() = 0;

        Window.Close();
        Message(SuccessMsg, ItemsProcessed, TotalVariants);
        CurrPage.Update(false);
    end;

    local procedure GenerateVariantsForAllItems()
    var
        Item: Record Item;
        ItemSize: Record "Item Size";
        ItemColor: Record "Item Color";
        ItemMaterial: Record "Item Material";
        ItemVariantMgt: Codeunit "Item Variant Management";
        ConfirmMsg: Label 'This will generate item variants for all items that have sizes, colors, or materials defined. This may take some time. Continue?';
        SuccessMsg: Label 'Variants generated successfully for %1 item(s). Total variants created: %2.';
        Window: Dialog;
        ItemsProcessed: Integer;
        TotalItems: Integer;
        TotalVariants: Integer;
        VariantCount: Integer;
        ItemsWithAttributes: List of [Code[20]];
        ItemNo: Code[20];
    begin
        if not Confirm(ConfirmMsg, false) then
            exit;

        // Find all items that have at least one attribute defined
        ItemSize.Reset();
        if ItemSize.FindSet() then
            repeat
                if not ItemsWithAttributes.Contains(ItemSize."Item No.") then
                    ItemsWithAttributes.Add(ItemSize."Item No.");
            until ItemSize.Next() = 0;

        ItemColor.Reset();
        if ItemColor.FindSet() then
            repeat
                if not ItemsWithAttributes.Contains(ItemColor."Item No.") then
                    ItemsWithAttributes.Add(ItemColor."Item No.");
            until ItemColor.Next() = 0;

        ItemMaterial.Reset();
        if ItemMaterial.FindSet() then
            repeat
                if not ItemsWithAttributes.Contains(ItemMaterial."Item No.") then
                    ItemsWithAttributes.Add(ItemMaterial."Item No.");
            until ItemMaterial.Next() = 0;

        TotalItems := ItemsWithAttributes.Count();

        if TotalItems = 0 then begin
            Message('No items found with sizes, colors, or materials defined.');
            exit;
        end;

        Window.Open('Generating Item Variants...\\Processing item #1#### of #2#### : #3########');

        ItemsProcessed := 0;
        TotalVariants := 0;
        foreach ItemNo in ItemsWithAttributes do begin
            ItemsProcessed += 1;
            if Item.Get(ItemNo) then begin
                Window.Update(1, ItemsProcessed);
                Window.Update(2, TotalItems);
                Window.Update(3, Item.Description);
                VariantCount := ItemVariantMgt.GenerateItemVariantsSilent(ItemNo);
                TotalVariants += VariantCount;
            end;
        end;

        Window.Close();
        Message(SuccessMsg, ItemsProcessed, TotalVariants);
        CurrPage.Update(false);
    end;

    local procedure FilterItemsWithAttributes()
    var
        ItemSize: Record "Item Size";
        ItemColor: Record "Item Color";
        ItemMaterial: Record "Item Material";
        ItemsWithAttributes: List of [Code[20]];
        FilterText: Text;
    begin
        // Find all items that have at least one attribute defined
        ItemSize.Reset();
        if ItemSize.FindSet() then
            repeat
                if not ItemsWithAttributes.Contains(ItemSize."Item No.") then
                    ItemsWithAttributes.Add(ItemSize."Item No.");
            until ItemSize.Next() = 0;

        ItemColor.Reset();
        if ItemColor.FindSet() then
            repeat
                if not ItemsWithAttributes.Contains(ItemColor."Item No.") then
                    ItemsWithAttributes.Add(ItemColor."Item No.");
            until ItemColor.Next() = 0;

        ItemMaterial.Reset();
        if ItemMaterial.FindSet() then
            repeat
                if not ItemsWithAttributes.Contains(ItemMaterial."Item No.") then
                    ItemsWithAttributes.Add(ItemMaterial."Item No.");
            until ItemMaterial.Next() = 0;

        if ItemsWithAttributes.Count() = 0 then begin
            Message('No items found with sizes, colors, or materials defined.');
            exit;
        end;

        // Build filter text
        FilterText := BuildFilterFromList(ItemsWithAttributes);
        Rec.SetFilter("No.", FilterText);
        CurrPage.Update(false);
    end;

    local procedure BuildFilterFromList(ItemList: List of [Code[20]]): Text
    var
        ItemNo: Code[20];
        FilterText: Text;
    begin
        foreach ItemNo in ItemList do begin
            if FilterText <> '' then
                FilterText := FilterText + '|';
            FilterText := FilterText + ItemNo;
        end;
        exit(FilterText);
    end;
}
