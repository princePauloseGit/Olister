namespace TasksActivityModule.TasksActivityModule;
using Microsoft.Inventory.Item;
using ChilternGlobalBC.ChilternGlobalBC;
using Microsoft.Projects.Project.Job;
using Microsoft.Pricing.PriceList;
using Microsoft.Pricing.Source;
using Microsoft.Sales.Customer;
using Microsoft.Purchases.Vendor;

page 50213 "Create Price List"
{
    ApplicationArea = All;
    Caption = 'Create Price List';
    PageType = StandardDialog;
    // SourceTable = AANActivity;

    layout
    {
        area(Content)
        {
            Group(General)
            {
                field("Record ID"; Activityrec."Project No.")
                {
                    ToolTip = 'Specifies the value of the Record ID field.', Comment = '%';
                    Editable = false;
                }
                field("Project Name"; "Project Name")
                {
                    ToolTip = 'Specifies the value of the Project Name field.', Comment = '%';
                    Editable = false;
                }
                field(Item; Itemvar)
                {
                    Editable = false;
                }
                field("Customer No"; "Customer No.")
                {
                    TableRelation = Customer;
                    Visible = IsSale;
                    Editable = false;
                }
                field("Vendor No"; "Vendor No.")
                {

                    Visible = IsPurchase;
                    trigger OnLookup(var Text: Text): Boolean
                    var
                        VendorNo: Code[20];
                        Activity: Record AANActivity;
                    begin
                        VendorNo := "Vendor No.";
                        LookupVendorName(VendorNo);
                        Activity.SetFilter("Project No.", Activityrec."Project No.");
                        Activity.SetFilter("Vendor No.", VendorNo);
                        if Activity.FindFirst() then begin
                            Error('Price List for vendor %1 Already Exists, Activity No:%2', VendorNo, Activity."Activity No");
                        end;
                        "Vendor No." := VendorNo;
                    end;

                }
                field("Item Price"; "Item Price")
                {

                }
            }
        }
    }
    var
        Itemvar: Code[20];

        "Customer No.": Code[20];
        "Vendor No.": Code[20];
        "Project Name": text[100];
        Activityrec: Record AANActivity;
        "Item Price": Decimal;
        IsPurchase: Boolean;
        IsSale: Boolean;
        SPCode: Code[20];
        PPCode: Code[20];

    trigger OnOpenPage()
    var
        Project: Record Job;
    begin
        Project.Get(Activityrec."Project No.");
        Itemvar := Project."Item No";
        "Customer No." := Activityrec."Customer No.";
        "Project Name" := Project.Description;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        SourceType: Enum "Price Source Type";
        PriceType: Enum "Price Type";
        Sourcegroup: Enum "Price Source Group";
        ActivityMgt: Codeunit "Tasks & Activity Controller";
    begin
        if CloseAction = CloseAction::OK then begin

            if IsSale then
                CreatePriceList(SourceType::Customer, PriceType::Sale, Sourcegroup::Customer)
            else if IsPurchase then
                CreatePriceList(SourceType::Vendor, PriceType::Purchase, Sourcegroup::Vendor);
        end
        else
            CurrPage.Close();
    end;

    procedure CreatePriceList(SourceType: Enum "Price Source Type"; PriceType: Enum "Price Type"; Sourcegroup: Enum "Price Source Group")
    var
        PLH: Record "Price List Header";
        PLL: Record "Price List Line";
        vendor: Record "Vendor";
        customer: Record "Customer";
    begin

        if IsSale then begin

            PLH.SetFilter("Source No.", "Customer No.");
            PLH.SetRange("Source Type", SourceType::Customer);
            PLH.SetRange("Price Type", "Price Type"::Sale);
        end
        else if IsPurchase then begin
            PLH.SetFilter("Source No.", "Vendor No.");
            PLH.SetRange("Source Type", SourceType::Vendor);
            PLH.SetRange("Price Type", "Price Type"::Purchase);
        end;
        if PLH.FindFirst() then begin
            CreatePriceListLines(PLH);

        end
        else begin
            Clear(PLH);
            PLH.Init();
            PLH.Validate(Code);
            if IsSale then begin
                customer.Get("Customer No.");
                PLH.Validate("Source Type", SourceType::Customer);
                PLH.Validate("Source Group", Sourcegroup::Customer);
                PLH.Validate("Price Type", "Price Type"::Sale);
                PLH.Validate("Assign-to No.", "Customer No.");
                PLH.Validate("Source No.", "Customer No.");
                PLH.Validate(Description, customer.Name);
            end
            else if IsPurchase then begin
                PLH.Validate("Source Type", SourceType::Vendor);
                PLH.Validate("Source Group", Sourcegroup::Vendor);
                PLH.Validate("Price Type", "Price Type"::Purchase);
                PLH.Validate("Assign-to No.", "Vendor No.");
                PLH.Validate("Source No.", "Vendor No.");
                PLH.Validate(Description, vendor.Name);
            end;

            PLH.Validate("Status", PLH.Status::Active);
            PLH.Insert(true);
            CreatePriceListLines(PLH);
            if IsSale then
                Message('Sales Project Price List No: %1 has been created', PLH.Code)
            else
                if IsPurchase then
                    Message('Purchase Project Price List No: %1 has been created', PLH.Code);
        end;


    end;

    procedure CreatePriceListLines(var PLH: Record "Price List Header")
    var
        PLL: Record "Price List Line";
    begin
        PLL.Init();

        if isSale then begin
            PLL.Validate("Price Type", "Price Type"::Sale);
            PLL.Validate("Source Type", PLL."Source Type"::Customer);
            PLL.Validate("Amount Type", PLL."Amount Type"::Any);
            PLL.Validate("Assign-to No.", PLH."Assign-to No.");
            PLL.Validate("Source Group", "Price Source Group"::Customer);
            PLL.Validate("Source No.", PLH."Source No.");
            PLL.Validate("Price List Code", PLH.Code);
            SPCode := PLH.Code;
        end
        else if IsPurchase then begin
            PLL.Validate("Price Type", "Price Type"::Purchase);
            PLL.Validate("Source Type", PLL."Source Type"::Vendor);
            PLL.Validate("Amount Type", PLL."Amount Type"::Any);
            PLL.Validate("Assign-to No.", PLH."Assign-to No.");
            PLL.Validate("Source Group", "Price Source Group"::Vendor);
            PLL.Validate("Source No.", PLH."Source No.");
            PLL.Validate("Price List Code", PLH.Code);
            PPCode := PLH.Code;
        end;
        PLL.Validate("Asset Type", PLL."Asset Type"::Item);
        PLL.Validate("Product No.", Itemvar);
        PLL.Validate("Asset No.", Itemvar);
        PLL.Validate("Project No.", Activityrec."Project No.");
        PLL.Validate(Status, PLL.Status::Active);
        PLL.Validate("Line No.");
        if IsSale then
            PLL.Validate("Unit Price", "Item Price");
        if IsPurchase then begin
            PLL.Validate("Unit Cost", "Item Price");
            PLL.Validate("Direct Unit Cost", "Item Price");
        end;

        PLL.Insert(true);

    end;

    procedure Getdata(
        "Activity": Record AANActivity;
        G_IsPurchase: Boolean;
        G_IsSale: Boolean)
    begin
        Activityrec := Activity;
        IsPurchase := G_IsPurchase;
        IsSale := G_IsSale;
    end;

    procedure setdata(var "Sales Price List code": Code[20]; Var "Purchase Price List code": Code[20]; Var "Vend No.": Code[20]; var "ItemNo": Code[20]);
    begin
        "Sales Price List code" := SPCode;
        "Purchase Price List code" := PPCode;
        "Vend No." := "Vendor No.";
        "ItemNo" := Itemvar;
    end;

    procedure LookupVendorName(var VendorNo: code[20]): Boolean
    var
        RecVariant: Variant;
        SearchVendorNo: Code[20];
        Projectvendor: Record "Project vendors";

    begin
        SearchVendorNo := VendorNo;
        // Vendor.SetRange(Blocked, Vendor.Blocked::" ");
        if "Vendor No." <> '' then
            Projectvendor.Get(Activityrec."Project No.", "Vendor No.");

        if SelectVendor(Projectvendor) then begin
            if "Vendor No." = Projectvendor."Vendor No" then
                VendorNo := SearchVendorNo
            else
                VendorNo := Projectvendor."Vendor No";
            exit(true);
        end;
    end;

    procedure SelectVendor(var Vendor: Record "Project vendors"): Boolean
    var
        VendorLookup: Page "Project Vendor Subform";
        PreviousVendorCode: Code[20];
        Result: Boolean;
    begin
        Vendor.SetFilter("Project No", Activityrec."Project No.");
        VendorLookup.SetTableView(Vendor);
        VendorLookup.SetRecord(Vendor);
        VendorLookup.LookupMode := true;
        PreviousVendorCode := Vendor."Vendor No";

        VendorLookup.RunModal();
        VendorLookup.GetRecord(Vendor);
        Result := Vendor."Vendor No" <> PreviousVendorCode;

        if not Result then
            Clear(Vendor);

        exit(Result);
    end;

}