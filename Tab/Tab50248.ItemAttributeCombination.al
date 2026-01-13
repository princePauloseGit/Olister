table 50248 "Item Attribute Combination"
{
    Caption = 'Item Attribute Combination';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item."No.";
        }
        field(3; "Size Code"; Code[20])
        {
            Caption = 'Size Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Size".Code;
        }
        field(4; "Color Code"; Code[20])
        {
            Caption = 'Color Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Color".Code;
        }
        field(5; "Material Code"; Code[20])
        {
            Caption = 'Material Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Material".Code;
        }
        field(6; "Item Variant Code"; Code[10])
        {
            Caption = 'Item Variant Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Variant".Code where("Item No." = field("Item No."));
        }
        field(7; "Size Description"; Text[100])
        {
            Caption = 'Size Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Size".Description where(Code = field("Size Code")));
            Editable = false;
        }
        field(8; "Color Description"; Text[100])
        {
            Caption = 'Color Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Color".Description where(Code = field("Color Code")));
            Editable = false;
        }
        field(9; "Material Description"; Text[100])
        {
            Caption = 'Material Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Material".Description where(Code = field("Material Code")));
            Editable = false;
        }
        field(10; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(ItemKey; "Item No.", "Size Code", "Color Code", "Material Code")
        {
        }
    }

    trigger OnInsert()
    begin
        // Variant creation is now handled manually via the "Sync to Variant" button
        // This avoids issues with AutoIncrement fields and gives users better control
    end;

    local procedure CreateOrUpdateItemVariant(VariantCode: Code[10])
    var
        ItemVariant: Record "Item Variant";
    begin
        // Check if variant already exists
        if ItemVariant.Get(Rec."Item No.", VariantCode) then begin
            // Update existing variant with attribute codes
            ItemVariant.Validate("Size Code", Rec."Size Code");
            ItemVariant.Validate("Color Code", Rec."Color Code");
            ItemVariant.Validate("Material Code", Rec."Material Code");
            ItemVariant.Modify(true);
            exit;
        end;

        // Create new variant
        ItemVariant.Init();
        ItemVariant.Validate("Item No.", Rec."Item No.");
        ItemVariant.Validate(Code, VariantCode);
        ItemVariant.Description := GenerateVariantDescription();
        ItemVariant.Validate("Size Code", Rec."Size Code");
        ItemVariant.Validate("Color Code", Rec."Color Code");
        ItemVariant.Validate("Material Code", Rec."Material Code");

        if not ItemVariant.Insert(true) then
            Error('Failed to create Item Variant. Variant Code: %1 for Item: %2', VariantCode, Rec."Item No.");
    end;

    procedure GenerateVariantCode(): Code[10]
    var
        VariantCode: Text;
    begin
        VariantCode := '';

        if Rec."Size Code" <> '' then
            VariantCode := Rec."Size Code";

        if Rec."Color Code" <> '' then begin
            if VariantCode <> '' then
                VariantCode := VariantCode + '-';
            VariantCode := VariantCode + Rec."Color Code";
        end;

        if Rec."Material Code" <> '' then begin
            if VariantCode <> '' then
                VariantCode := VariantCode + '-';
            VariantCode := VariantCode + Rec."Material Code";
        end;

        // If no attributes, create a unique code
        if VariantCode = '' then
            VariantCode := Format(Rec."Entry No.");

        exit(CopyStr(VariantCode, 1, 10));
    end;

    procedure GenerateVariantDescription(): Text[100]
    var
        ItemSize: Record "Item Size";
        ItemColor: Record "Item Color";
        ItemMaterial: Record "Item Material";
        Description: Text;
    begin
        Description := '';

        if (Rec."Size Code" <> '') and ItemSize.Get(Rec."Size Code") then begin
            Description := ItemSize.Description;
        end;

        if (Rec."Color Code" <> '') and ItemColor.Get(Rec."Color Code") then begin
            if Description <> '' then
                Description := Description + ', ';
            Description := Description + ItemColor.Description;
        end;

        if (Rec."Material Code" <> '') and ItemMaterial.Get(Rec."Material Code") then begin
            if Description <> '' then
                Description := Description + ', ';
            Description := Description + ItemMaterial.Description;
        end;

        exit(CopyStr(Description, 1, 100));
    end;
}
