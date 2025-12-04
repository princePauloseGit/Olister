page 50222 "New Product Card"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Tasks;
    SourceTable = Item;
    SourceTableTemporary = true;
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(IsExistingItem; IsExistingItem)
                {
                    Caption = 'Use an Existing Product';
                    trigger OnValidate()
                    begin

                        if not IsExistingItem then begin
                            Clear(Rec.Description);
                            Clear(Rec."Base Unit of Measure");
                            Clear(Rec."Item Category Code");
                            Clear(Rec."Purchasing Code");
                            Clear(Rec."Gen. Prod. Posting Group");
                            Clear(Rec."VAT Bus. Posting Gr. (Price)");
                            Clear(Rec."VAT Prod. Posting Group");
                            Clear(ExistingItemNo);
                            Clear(ItemTmpl);
                        end;
                        CurrPage.Update(true);
                    end;
                }
                field(ExistingItemNo; ExistingItemNo)
                {
                    Caption = 'Item No';
                    TableRelation = Item;
                    Editable = IsExistingItem;
                    trigger OnValidate()
                    var
                        itemL: Record Item;
                    begin
                        if ExistingItemNo <> '' then begin
                            if itemL.Get(ExistingItemNo) then begin
                                Rec.Description := itemL.Description;
                                Rec."Base Unit of Measure" := itemL."Base Unit of Measure";
                                Rec."Item Category Code" := itemL."Item Category Code";
                                Rec."Purchasing Code" := itemL."Purchasing Code";
                                Rec."Product Category Code" := itemL."Product Category Code";
                                Rec."Product Group Code" := itemL."Product Group Code";
                                Rec."Product Type Code" := itemL."Product Type Code";
                                Rec.TransferFields(itemL, false);
                                ItemNo := ExistingItemNo;
                            end;
                        end;
                        CurrPage."Item Attribute Value List".PAGE.LoadAttributes(ExistingItemNo);
                    end;
                }
                field("Item Template"; ItemTmpl)
                {
                    TableRelation = "Item Templ.";
                    Editable = Not IsExistingItem;
                    trigger OnValidate()
                    var
                        RecItemTemplate: Record "Item Templ.";
                    begin
                        if RecItemTemplate.Get(ItemTmpl) then
                            Rec.TransferFields(RecItemTemplate);
                    end;
                }
                group(Details)
                {


                    field(Description; Rec.Description)
                    {
                        ApplicationArea = all;

                    }

                    field("Base Unit of Measure"; Rec."Base Unit of Measure")
                    {
                        Caption = 'Base Unit of Measure';
                        TableRelation = "Unit of Measure";

                    }
                    field("Item Category Code"; Rec."Item Category Code")
                    {
                        Caption = 'Item Category Code';
                        TableRelation = "Item Category";
                    }
                    field("Purchasing Code"; Rec."Purchasing Code")
                    {
                        Caption = 'Purchasing Code';
                        TableRelation = Purchasing;
                    }
                    field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                    {
                        Caption = 'Gen. Prod. Posting Group';
                        TableRelation = "Gen. Product Posting Group";
                    }
                    field("VAT Bus. Posting Gr. (Price)"; Rec."VAT Bus. Posting Gr. (Price)")
                    {
                        Caption = 'VAT Bus. Posting Gr. (Price)';
                        TableRelation = "VAT Business Posting Group";
                    }
                    field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                    {
                        Caption = 'VAT Prod. Posting Group';
                        TableRelation = "VAT Product Posting Group";
                    }
                    field("Product Type Code"; Rec."Product Type Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Product Category Code"; Rec."Product Category Code")
                    {
                        ApplicationArea = All;
                    }
                    field("Product Group Code"; Rec."Product Group Code")
                    {
                        ApplicationArea = All;
                    }

                }
                part("Item Attribute Value List"; "Product Attribute Value List")
                {
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        attr: Record "Item Attribute Value Selection";
    begin
        if CloseAction = CloseAction::OK then begin

            if not IsExistingItem then
                CreateItem();
            CreateProject();
            CurrPage."Item Attribute Value List".Page.RenameAttributeItemNo(attr, ItemNo);
        end
        else if CloseAction = CloseAction::Cancel then begin
            CurrPage."Item Attribute Value List".Page.DeleteTempAttributes(attr, Rec."No.");

        end;
    end;

    trigger OnOpenPage()
    begin
        CurrPage.Editable(true);
        CurrPage."Item Attribute Value List".PAGE.LoadAttributes(Rec."No.");
    end;



    procedure GetData(Var "item No": Code[20]; Var "Project No": Code[20])
    begin
        "item No" := ItemNo;
        "Project No" := ProjectNo;
    end;

    procedure CreateItem()
    var
        Item: Record Item;
    begin
        Item.Init();
        Item.Validate("Base Unit of Measure", Rec."Base Unit of Measure");
        Item.Validate("Item Category Code", Rec."Item Category Code");
        Item.Validate("Purchasing Code", Rec."Purchasing Code");
        Item.TransferFields(Rec, false);
        Item.Validate("No.");
        Item.Validate(Description, Rec.Description);
        Item.Validate(Blocked, true);
        Item.Insert(true);

        ItemNo := Item."No.";
        P_Description := Item.Description;

    end;

    procedure CreateProject()
    var
        Project: Record Job;
        ItemRec: Record Item;
        Enquiry: Record Enquiry;
    begin
        Enquiry.Get(EnqNo);
        Project.Init();
        Project.Validate("No.");
        Project.Validate("Bill-to Customer No.", CustNo);
        if ItemNo <> '' then begin
            if ItemRec.Get(ItemNo) then begin

            end;
            Project.Validate("Item No", ItemNo);
        end;
        Project.Validate("Enquiry No", EnqNo);
        Project.Validate(Description, Rec.Description);
        Project.Validate("Sell-to Customer No.", Enquiry."Customer No.");
        Project.Validate("Product Category", Rec."Product Category Code");
        Project.Validate("Product Group", Rec."Product Group Code");
        Project.Validate("Product Type", Rec."Product Type Code");
        Project.Insert(true);
        ProjectNo := Project."No.";
    end;

    procedure SetTempItemData(var TempItem: Record Item; "Enquiry No.": Code[20])
    begin
        EnqNo := "Enquiry No.";
        Rec.Init();
        Rec := TempItem;
        Rec.Insert();
    end;


    var
        EnqNo, CustNo, ItemNo, ProjectNo, ExistingItemNo, ItemTmpl : Code[20];

        P_Description: Text[100];
        //RecVariables
        IsExistingItem: Boolean;
}