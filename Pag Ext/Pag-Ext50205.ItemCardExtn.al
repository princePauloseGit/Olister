namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Item;
using Microsoft.Projects.Project.Job;
using Microsoft.Sales.Customer;
using System.Security.AccessControl;
using Microsoft.Inventory.Item.Attribute;
using Microsoft.Inventory.Setup;
using Microsoft.Foundation.NoSeries;
using TasksActivityModule.TasksActivityModule;

pageextension 50205 ItemCardExtn extends "Item Card"
{
    layout
    {
        movebefore("No."; Description)
        addafter("No.")
        {
            field("Previous Version"; Rec."Previous Version")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Next Version"; Rec."Next Version")
            {
                ApplicationArea = All;
                Editable = false;
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
        addafter(Item)
        {
            group("Variant Attributes")
            {
                Caption = 'Variant Attributes';
                field("Item Sizes Count"; GetItemSizesCount())
                {
                    ApplicationArea = All;
                    Caption = 'Number of Sizes';
                    Editable = false;
                    ToolTip = 'Shows the number of sizes defined for this item.';
                    Style = Strong;

                    trigger OnDrillDown()
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
                field("Item Colors Count"; GetItemColorsCount())
                {
                    ApplicationArea = All;
                    Caption = 'Number of Colors';
                    Editable = false;
                    ToolTip = 'Shows the number of colors defined for this item.';
                    Style = Strong;

                    trigger OnDrillDown()
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
                field("Item Materials Count"; GetItemMaterialsCount())
                {
                    ApplicationArea = All;
                    Caption = 'Number of Materials';
                    Editable = false;
                    ToolTip = 'Shows the number of materials defined for this item.';
                    Style = Strong;

                    trigger OnDrillDown()
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
            }
            group("Product Details")
            {
                Caption = 'Product Details';
                field("Core Product"; Rec."Core Product")
                {
                    ApplicationArea = All;
                }
                field(Brochure; Rec.Brochure)
                {
                    ApplicationArea = All;
                }
                field(Cost; Rec.Cost)
                {
                    ApplicationArea = All;
                }
                field(Trade; Rec.Trade)
                {
                    ApplicationArea = All;
                }
                field(MAP; Rec.MAP)
                {
                    ApplicationArea = All;
                }
                field(RRP; Rec.RRP)
                {
                    ApplicationArea = All;
                }
                field("Archive Products"; Rec."Archive Products")
                {
                    ApplicationArea = All;
                }
                field("CG Website"; Rec."CG Website")
                {
                    ApplicationArea = All;
                }
                field("Prokyt Website"; Rec."Prokyt Website")
                {
                    ApplicationArea = All;
                }
                field("Prokyt Cato"; Rec."Prokyt Cato")
                {
                    ApplicationArea = All;
                }
            }
        }
        addafter("Qty. on Sales Order")
        {
            field("Qty. on Purch. Quote"; Rec."Qty. on Purch. Quote")
            {
                ApplicationArea = All;
            }
            field("Qty. on Sales Quote"; Rec."Qty. on Sales Quote")
            {
                ApplicationArea = All;
            }
        }
        modify("Attached Documents List")
        {
            Visible = false;
        }
        addafter(ItemPicture)
        {
            part(itemNavigation; "Item Navigation")
            {
                ApplicationArea = All;
                Caption = 'Item Navigation';
                SubPageLink = "No." = field("No.");
            }

            part(DocAttachmentFactbox; "Doc Attachment FactBox")
            {
                UpdatePropagation = Both;
                Caption = 'Attachment Upload';
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(Database::Item), "Document No." = field("No.");
                //Attachments Through Activity Only
                Visible = false;
            }


            part(Activities; "Activity List Part FactBox")
            {
                UpdatePropagation = Both;
                Caption = 'Related Activity';
                ApplicationArea = All;
                SubPageLink = "Record No." = field("No."), "Table Name" = const('Item');
            }
        }
    }
    actions
    {
        addafter(PricesandDiscounts)
        {
            group(Version)
            {
                Caption = 'Version';
                action(CreateNewVersion)
                {
                    Caption = 'Create New Version';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        NewItem: Record Item;
                        ItemNoSeriesMgt: Codeunit "No. Series";
                        InvSetup: Record "Inventory Setup";
                    begin
                        InvSetup.Get();
                        NewItem.Init();
                        NewItem := Rec;
                        NewItem."Previous Version" := Rec."No.";
                        NewItem."No." := ItemNoSeriesMgt.GetNextNo(InvSetup."Item Nos.");
                        NewItem.Insert();
                        Rec."Next Version" := NewItem."No.";
                        CopyAttributesToNextVersion(NewItem);
                        CopyItemVariants(Rec."No.", NewItem."No.", NewItem.SystemId);
                        CurrPage.Update();
                        Run(Page::"Item Card", NewItem);
                    end;
                }
                action(ViewVersionHistory)
                {
                    Caption = 'View Version History';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        ItemVersionHistory: Page "Item Version List";
                        Item: Record Item;
                        ItemNo: Code[20];
                        ItemversionTracker: Record "Item Version Tracker" temporary;
                        user: Record User;
                        SrNo: Integer;
                    begin
                        ItemNo := Rec."No.";
                        Item.Get(Rec."No.");
                        SrNo := 1;
                        while Item."Previous Version" <> '' do
                            Item.Get(Item."Previous Version");


                        while Item."Next Version" <> '' do begin
                            Item.Get(Item."Next Version");
                            ItemversionTracker.Init();
                            ItemversionTracker."Item No" := Item."Previous Version";
                            ItemversionTracker."Next Version" := Item."No.";
                            ItemversionTracker."Created date" := Item.SystemCreatedAt;
                            ItemversionTracker."Serial No." := SrNo;
                            if user.Get(Item.SystemCreatedBy) then
                                ItemversionTracker."Created By" := user."Full Name";
                            ItemversionTracker.Insert();

                            SrNo += 1;
                        end;

                        ItemversionTracker.SetCurrentKey("Serial No.");
                        ItemversionTracker.Ascending(true);
                        RunModal(Page::"Item Version Tracker", ItemversionTracker);
                    end;
                }
                action(PreviousVersion)
                {
                    Caption = 'Previous Version';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        Item: Record Item;
                    begin
                        if Rec."Previous Version" <> '' then begin
                            if Item.Get(Rec."Previous Version") then
                                Run(Page::"Item Card", Item)
                            else
                                Error('No Previous Version found');
                        end
                        else
                            Error('No Previous Version found');
                    end;
                }
                action(NextVersion)
                {
                    Caption = 'Next Version';
                    ApplicationArea = All;
                    trigger OnAction()
                    var
                        Item: Record Item;
                    begin
                        if Rec."Next Version" <> '' then begin
                            if Item.Get(Rec."Next Version") then
                                Run(Page::"Item Card", Item)
                            else
                                Error('No Next Version found');
                        end
                        else
                            Error('No Next Version found');
                    end;
                }

            }

            group(Projects)
            {
                Caption = 'Projects';
                Image = Job;
                action(ActiveProjects)
                {
                    Caption = 'Active Projects';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = Status = filter("Job Status"::Open);
                }
                action(CustomerOrders)
                {
                    Caption = 'Customer Orders';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = Status = filter("Job Status"::"Customer Order");
                }
                action(ShippingAndDelivery)
                {
                    Caption = 'Shipping and Delivery';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = Status = filter("Job Status"::"Shipping & Delivery");
                }
                action(AwaitsCustomer)
                {
                    Caption = 'Awaiting Customer';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = Status = filter("Job Status"::"Awaits Customer");
                }
                action(Tenders)
                {
                    Caption = 'Tenders';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = Status = filter("Job Status"::Tenders);
                }
                action(Research)
                {
                    Caption = 'Research';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = Status = filter("Job Status"::Research);
                }
                action("Materials&Parts")
                {
                    Caption = 'Materials & Parts';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = Status = filter("Job Status"::"Materials & Parts");
                }
                action(Terminology)
                {
                    Caption = 'Terminology';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = Status = filter("Job Status"::Terminology);
                }
                action(Closed)
                {
                    Caption = 'Closed';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = Status = filter("Job Status"::Completed);
                }
                action(AllProjects)
                {
                    Caption = 'All Projects';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                }
            }
            group(VariantAttributes)
            {
                Caption = 'Variant Attributes';
                Image = Dimensions;
                
                action(ManageItemSizes)
                {
                    Caption = 'Manage Item Sizes';
                    ApplicationArea = All;
                    Image = Dimensions;
                    ToolTip = 'Manage sizes for this item.';

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
                action(ManageItemColors)
                {
                    Caption = 'Manage Item Colors';
                    ApplicationArea = All;
                    Image = ItemGroup;
                    ToolTip = 'Manage colors for this item.';

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
                action(ManageItemMaterials)
                {
                    Caption = 'Manage Item Materials';
                    ApplicationArea = All;
                    Image = Production;
                    ToolTip = 'Manage materials for this item.';

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
                action(GenerateItemVariants)
                {
                    Caption = 'Generate Item Variants';
                    ApplicationArea = All;
                    Image = CreateDocument;
                    ToolTip = 'Generate all item variant combinations based on sizes, colors, and materials.';

                    trigger OnAction()
                    var
                        ItemVariantMgt: Codeunit "Item Variant Management";
                    begin
                        ItemVariantMgt.GenerateItemVariants(Rec."No.");
                        CurrPage.Update(false);
                    end;
                }
            }
            group(Activity)
            {
                action(OpenActivities)
                {
                    Caption = 'Open';
                    ApplicationArea = all;
                    Image = Task;
                    RunPageView = where(Status = filter('open'));
                    RunObject = page "AANActivity List";
                }
                action(AllActivities)
                {
                    Caption = 'All Activities (Administrator)';
                    ApplicationArea = all;
                    Image = Task;
                    RunObject = page "AANActivity List";
                }
                action(CreatedActivities)
                {
                    Caption = 'Created Activities';
                    ApplicationArea = all;
                    Image = Task;
                    //                    RunObject = page "AANActivity List";
                    trigger OnAction()
                    var
                        Activity: Record AANActivity;
                    begin
                        Activity.SetFilter("Created By", UserId);
                        Page.RunModal(Page::"AANActivity List", Activity);
                    end;
                }
            }
            Group(Group_Enquiries)
            {
                Caption = 'Enquiries';
                Image = Opportunity;
                action("Active Enquiries")
                {
                    Caption = 'ActiveEnquiries';
                    ApplicationArea = all;
                    Image = Opportunity;
                    RunObject = page Enquiries;
                    RunPageView = where(Status = filter("Enquiry Status"::Active));
                }
                action("Enquiry_Customer Orders")
                {
                    Caption = 'Customer Orders';
                    ApplicationArea = all;
                    Image = Opportunity;
                    RunObject = page Enquiries;
                    RunPageView = where(Status = filter("Enquiry Status"::"Customer Order"));
                }
                action("Enquiry_Research")
                {
                    Caption = 'Research';
                    ApplicationArea = all;
                    Image = Opportunity;
                    RunObject = page Enquiries;
                    RunPageView = where(Status = filter("Enquiry Status"::Research));
                }
                action("Enquiry_Terminology")
                {
                    Caption = 'Terminology';
                    ApplicationArea = all;
                    Image = Opportunity;
                    RunObject = page Enquiries;
                    RunPageView = where(Status = filter("Enquiry Status"::Terminology));
                }
                action("Enquiry_AwaitsCustomer")
                {
                    Caption = 'Awaits Customer';
                    ApplicationArea = all;
                    Image = Opportunity;
                    RunObject = page Enquiries;
                    RunPageView = where(Status = filter("Enquiry Status"::"Awaits Customer"));
                }
                action("Enquiry_Closed")
                {
                    Caption = 'Closed';
                    ApplicationArea = all;
                    Image = Opportunity;
                    RunObject = page Enquiries;
                    RunPageView = where(Status = filter("Enquiry Status"::Closed));
                }
                action("Enquiry_ShippingAndDelivery")
                {
                    Caption = 'Shipping & Delivery';
                    ApplicationArea = all;
                    Image = Opportunity;
                    RunObject = page Enquiries;
                    RunPageView = where(Status = filter("Enquiry Status"::"Shipping & Delivery"));
                }
                action("Enquiry_MaterialsAndParts")
                {
                    Caption = 'Materials & Parts';
                    ApplicationArea = all;
                    Image = Opportunity;
                    RunObject = page Enquiries;
                    RunPageView = where(Status = filter("Enquiry Status"::"Materials & Parts"));
                }

            }
        }

        addfirst(Promoted)
        {
            group(Projects_Promoted)
            {
                Caption = 'Projects';
                image = Job;
                actionref(AllProjects_Promoted; AllProjects)
                { }
                actionref(ClosedProjects_Promoted; Closed)
                { }
                actionref(ActiveProjects_Promoted; ActiveProjects)
                { }
                actionref(CustomerOrders_Promoted; CustomerOrders)
                { }
                actionref(ShippingAndDelivery_Promoted; ShippingAndDelivery)
                { }
                actionref(AwaitsCustomer_Promoted; AwaitsCustomer)
                { }
                actionref(Tenders_Promoted; Tenders)
                { }
                actionref(Research_Promoted; Research)
                { }
                actionref(MaterialsAndParts_Promoted; "Materials&Parts")
                { }
                actionref(Terminology_Promoted; Terminology)
                { }
            }
            group(Activities_Promoted)
            {
                Caption = 'Activities';
                image = Task;
                actionref(OpenActivities_Promoted; OpenActivities)
                { }
                actionref(AllActivities_Promoted; AllActivities)
                { }
                actionref(CreatedActivities_Promoted; CreatedActivities)
                { }
            }
            group(EnquiriesGroup_Promoted)
            {
                Caption = 'Enquiries';
                actionref(Enquiries_Promoted; "Active Enquiries")
                { }
                actionref(Enquiry_CustomerOrders_Promoted; "Enquiry_Customer Orders")
                { }
                actionref(Enquiry_Research_Promoted; "Enquiry_Research")
                { }
                actionref(Enquiry_ShippingAndDelivery_Promoted; "Enquiry_ShippingAndDelivery")
                {

                }
                actionref(Enquiry_MaterialsAndParts_Promoted; "Enquiry_MaterialsAndParts")
                { }
                actionref(Enquiry_Terminology_Promoted; "Enquiry_Terminology")
                { }
                actionref(Enquiry_AwaitsCustomer_Promoted; "Enquiry_AwaitsCustomer")
                { }
                actionref(Enquiry_Closed_Promoted; "Enquiry_Closed")
                { }


            }
            group(Version_Promoted)
            {
                Caption = 'Version';
                actionref(CreateNewVersion_Promoted; CreateNewVersion)
                { }
                actionref(ViewVersionHistory_Promoted; ViewVersionHistory)
                { }
                actionref(PreviousVersion_Promoted; PreviousVersion)
                { }
                actionref(NextVersion_Promoted; NextVersion)
                { }
            }
            group(VariantAttributes_Promoted)
            {
                Caption = 'Variant Attributes';
                Image = Dimensions;
                actionref(ManageItemSizes_Promoted; ManageItemSizes)
                { }
                actionref(ManageItemColors_Promoted; ManageItemColors)
                { }
                actionref(ManageItemMaterials_Promoted; ManageItemMaterials)
                { }
                actionref(GenerateItemVariants_Promoted; GenerateItemVariants)
                { }
            }
        }
    }
    procedure CopyAttributesToNextVersion(NextItem: Record Item)
    var
        ItemAttributeValMapping: Record "Item Attribute Value Mapping";
        ItemAttributeValMapping2: Record "Item Attribute Value Mapping";

    begin
        ItemAttributeValMapping.SetRange("Table ID", Database::Item);
        ItemAttributeValMapping.SetFilter("No.", Rec."No.");
        if ItemAttributeValMapping.FindSet() then
            repeat
                if ItemAttributeValMapping2.Get(Database::Item, NextItem."No.", ItemAttributeValMapping."Item Attribute ID") then begin
                    ItemAttributeValMapping2."Item Attribute Value ID" := ItemAttributeValMapping."Item Attribute Value ID";
                    ItemAttributeValMapping2.Modify();
                end
                else begin
                    Clear(ItemAttributeValMapping2);
                    ItemAttributeValMapping2.Init();
                    ItemAttributeValMapping2."Table ID" := Database::Item;
                    ItemAttributeValMapping2."No." := NextItem."No.";
                    ItemAttributeValMapping2."Item Attribute ID" := ItemAttributeValMapping."Item Attribute ID";
                    ItemAttributeValMapping2."Item Attribute Value ID" := ItemAttributeValMapping."Item Attribute Value ID";
                    ItemAttributeValMapping2.Insert();
                end;
            until ItemAttributeValMapping.Next() = 0;

    end;

    local procedure CopyItemVariants(FromItemNo: Code[20]; ToItemNo: Code[20]; ToItemId: Guid)
    var
        ItemVariant: Record "Item Variant";
        CopyItem: Codeunit "Copy Item";
    begin
        CopyItem.CopyItemRelatedTable(Database::"Item Variant", ItemVariant.FieldNo("Item No."), FromItemNo, ToItemNo);
        ItemVariant.SetRange("Item No.", ToItemNo);
        if not ItemVariant.IsEmpty() then
            ItemVariant.ModifyAll("Item Id", ToItemId);
    end;

    local procedure GetItemSizesCount(): Integer
    var
        ItemSize: Record "Item Size";
    begin
        ItemSize.SetRange("Item No.", Rec."No.");
        exit(ItemSize.Count());
    end;

    local procedure GetItemColorsCount(): Integer
    var
        ItemColor: Record "Item Color";
    begin
        ItemColor.SetRange("Item No.", Rec."No.");
        exit(ItemColor.Count());
    end;

    local procedure GetItemMaterialsCount(): Integer
    var
        ItemMaterial: Record "Item Material";
    begin
        ItemMaterial.SetRange("Item No.", Rec."No.");
        exit(ItemMaterial.Count());
    end;
}