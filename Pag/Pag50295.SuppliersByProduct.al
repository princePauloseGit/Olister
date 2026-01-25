namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Purchases.Vendor;

page 50295 "Suppliers by Product"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Vendor;
    Caption = 'Suppliers by Product';
    CardPageId = "Vendor Card";

    layout
    {
        area(Content)
        {
            group(FilterGroup)
            {
                Caption = 'Filters';

                field(ProductTypeFilter; ProductTypeFilterText)
                {
                    ApplicationArea = All;
                    Caption = 'Product Type';
                    ToolTip = 'Filter by product type';

                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ProductType: Record "Product Type";
                    begin
                        if Page.RunModal(50224, ProductType) = Action::LookupOK then begin
                            Text := ProductType."Product Type Code";
                            ProductTypeFilterText := ProductType."Product Type Code";
                            ApplyFilters();
                        end;
                        exit(true);
                    end;
                }

                field(ProductCategoryFilter; ProductCategoryFilterText)
                {
                    ApplicationArea = All;
                    Caption = 'Product Category';
                    ToolTip = 'Filter by product category';

                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ProductCategory: Record "Product Category";
                    begin
                        if Page.RunModal(50225, ProductCategory) = Action::LookupOK then begin
                            Text := ProductCategory."Product Category Code";
                            ProductCategoryFilterText := ProductCategory."Product Category Code";
                            ApplyFilters();
                        end;
                        exit(true);
                    end;
                }

                field(ProductGroupFilter; ProductGroupFilterText)
                {
                    ApplicationArea = All;
                    Caption = 'Product Group';
                    ToolTip = 'Filter by product group';

                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        ProductGroup: Record "Product Group";
                    begin
                        if Page.RunModal(50226, ProductGroup) = Action::LookupOK then begin
                            Text := ProductGroup."Product Group Code";
                            ProductGroupFilterText := ProductGroup."Product Group Code";
                            ApplyFilters();
                        end;
                        exit(true);
                    end;
                }

                field(SupplierTypeFilter; SupplierTypeFilterText)
                {
                    ApplicationArea = All;
                    Caption = 'Supplier Type';
                    ToolTip = 'Filter by supplier type';

                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        TypeRec: Record "Type";
                    begin
                        if Page.RunModal(50208, TypeRec) = Action::LookupOK then begin
                            Text := TypeRec.Code;
                            SupplierTypeFilterText := TypeRec.Code;
                            ApplyFilters();
                        end;
                        exit(true);
                    end;
                }

                field(StatusFilter; StatusFilterOption)
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'Filter by supplier status';

                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;
                }
            }

            repeater(Group)
            {
                Editable = false;

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the supplier number.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the supplier name.';
                }
                field("Product Type"; Rec."Product Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the product type for the supplier.';
                }
                field("Product Category"; Rec."Product Category")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the product category for the supplier.';
                }
                field("Product Group"; Rec."Product Group")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the product group for the supplier.';
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                    Caption = 'Supplier Type';
                    ToolTip = 'Specifies the type of supplier.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the supplier.';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the supplier telephone number.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the supplier email address.';
                }
                field(Contact; Rec.Contact)
                {
                    ApplicationArea = All;
                    Caption = 'Primary Contact';
                    ToolTip = 'Specifies the primary contact person.';
                }
                field("Purchaser Code"; Rec."Purchaser Code")
                {
                    ApplicationArea = All;
                    Caption = 'Account Manager';
                    ToolTip = 'Specifies the account manager for the supplier.';
                }
                field(City; Rec.City)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the supplier city.';
                }
                field("Country/Region Code"; Rec."Country/Region Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the country/region code.';
                }
            }
        }
        area(FactBoxes)
        {
            part(VendorStatisticsFactBox; "Vendor Statistics FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
            part(VendorDetailsFactBox; "Vendor Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(VendorCard)
            {
                ApplicationArea = All;
                Caption = 'Supplier Card';
                Image = Vendor;
                RunObject = Page "Vendor Card";
                RunPageLink = "No." = field("No.");
                ToolTip = 'Open the supplier card.';
            }
        }
        area(Processing)
        {
            action(ClearFilters)
            {
                ApplicationArea = All;
                Caption = 'Clear All Filters';
                Image = ClearFilter;
                ToolTip = 'Clear all applied filters.';

                trigger OnAction()
                begin
                    ClearAllFilters();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        ApplyFilters();
    end;

    local procedure ApplyFilters()
    begin
        Rec.Reset();
        Rec.FilterGroup(2);

        if ProductTypeFilterText <> '' then
            Rec.SetFilter("Product Type", ProductTypeFilterText);

        if ProductCategoryFilterText <> '' then
            Rec.SetFilter("Product Category", ProductCategoryFilterText);

        if ProductGroupFilterText <> '' then
            Rec.SetFilter("Product Group", ProductGroupFilterText);

        if SupplierTypeFilterText <> '' then
            Rec.SetFilter(Type, SupplierTypeFilterText);

        if StatusFilterOption <> StatusFilterOption::" " then
            Rec.SetRange(Status, StatusFilterOption);

        Rec.FilterGroup(0);

        CurrPage.Update(false);
    end;

    local procedure ClearAllFilters()
    begin
        ProductTypeFilterText := '';
        ProductCategoryFilterText := '';
        ProductGroupFilterText := '';
        SupplierTypeFilterText := '';
        StatusFilterOption := StatusFilterOption::" ";

        Rec.Reset();
        CurrPage.Update(false);
    end;

    var
        ProductTypeFilterText: Code[20];
        ProductCategoryFilterText: Code[20];
        ProductGroupFilterText: Code[20];
        SupplierTypeFilterText: Code[20];
        StatusFilterOption: Enum Status;
}
