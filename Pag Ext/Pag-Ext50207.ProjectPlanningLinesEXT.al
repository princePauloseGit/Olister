namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Projects.Project.Planning;
using Microsoft.Projects.Project.Job;
using TasksActivityModule.TasksActivityModule;
using Microsoft.Sales.Document;
using Microsoft.Purchases.Document;
using Microsoft.Pricing.PriceList;

pageextension 50207 "Project Planning Lines EXT" extends "Job Planning Lines"
{
    actions
    {

        addLast(Creation)
        {
            action(CreateActivity)
            {
                Caption = 'Create an Activity';
                ApplicationArea = all;
                trigger OnAction()
                var
                    TasksController: Codeunit "Tasks & Activity Controller";
                begin
                    TasksController.CreateActivityFromPlanningLines(Rec);
                end;
            }
        }

        addafter(CreatePurchaseOrder)
        {
            action(CreatePurchaseQuote)
            {
                Image = Quote;
                Caption = 'Create Purchase Quote';
                ApplicationArea = all;
                trigger OnAction()
                var

                    PriceListLineSelection: Page "Price List Line Selection";
                begin
                    if (Rec.Type <> Rec.Type::Item) then
                        Error('Type Must Be Item');
                    if Rec."No." = '' then
                        Error('No Item Selected');
                    PriceList.SetFilter("Project No.", Rec."Job No.");
                    PriceList.SetFilter("Product No.", Rec."No.");
                    PriceList.SetRange("Price Type", PriceList."Price Type"::Purchase);
                    if PriceList.FindSet() then begin
                        if Page.RunModal(Page::"Price List Line Selection", PriceList) = Action::LookupOK then
                            CreatePurchaseQuote();
                    end else
                        Message('No Purchase Price Lists Found for this Project');
                end;
            }
            action(CreateSalesQuote)
            {
                Image = NewSalesQuote;
                Caption = 'Create Sales Quote';
                ApplicationArea = all;
                trigger OnAction()
                var
                    PriceListLineSelection: Page "Price List Line Selection";
                    Project: Record Job;
                begin
                    if (Rec.Type <> Rec.Type::Item) then
                        Error('Type Must Be Item');
                    if Rec."No." = '' then
                        Error('No Item Selected');
                    PriceList.SetFilter("Project No.", Rec."Job No.");
                    PriceList.SetFilter("Product No.", Rec."No.");
                    PriceList.SetRange("Price Type", PriceList."Price Type"::Sale);
                    Project.Get(Rec."Job No.");
                    PriceList.SetFilter("Source No.", Project."Bill-to Customer No.");
                    if PriceList.FindSet() then begin
                        if Confirm('Would you like to create a Sales Quote for Customer:%1', true, Project."Sell-to Customer No.") then
                            CreateSalesQuote();
                    end
                    else
                        Message('No Sales Price List Found for this Project');
                end;
            }
        }
        addfirst(Promoted)
        {
            actionref(CreateActivity_Promoted; CreateActivity)
            {
            }
        }
    }

    local procedure CreatePurchaseQuote()
    var
        PH: Record "Purchase Header";
        PL: Record "Purchase Line";
        Project: Record Job;
    begin

        // PriceLists.SetFilter("Project No.", Rec."Job No.");
        // PriceLists.SetFilter("Product No.", Rec."No.");
        // //PriceLists.SetFilter("Source No.",vendor);
        PH.Validate("Document Type", PH."Document Type"::Quote);
        PH.validate("posting date", today);
        PH.validate("Buy-from Vendor No.", PriceList."Source No.");
        PH.Insert(true);
        PH.Validate("Vendor Invoice No.", Rec."Job No." + PH."No.");
        PH.Modify();
        PL.Init();
        PL."Document No." := PH."No.";
        PL.Validate("Document Type", PL."Document Type"::Quote);
        PL.Validate(Type, PL.Type::Item);
        PL.Validate("No.", Rec."No.");
        PL.Validate(Quantity, Rec.Quantity);
        PL.Validate("Direct Unit Cost", PriceList."Unit Cost");
        PL.Insert();
        if Confirm('Purchase Quote No: %1 has been Created, Would you Like to Open It?', true, PH."No.") then
            Page.Run(Page::"Purchase Quote", PH);
    end;

    local procedure CreateSalesQuote()
    var
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        Project: Record Job;
    begin

        // PriceLists.SetFilter("Project No.", Rec."Job No.");
        // PriceLists.SetFilter("Product No.", Rec."No.");
        // //PriceLists.SetFilter("Source No.",vendor);
        SH.Validate("Document Type", SH."Document Type"::Quote);
        SH.validate("posting date", today);
        SH.validate("Sell-to Customer No.", PriceList."Source No.");
        SH.Insert(true);
        SH.Validate("Your Reference", Rec."Job No." + SH."No.");
        SH.Modify();
        SL.Init();
        SL."Document No." := SH."No.";
        SL.Validate("Document Type", SL."Document Type"::Quote);
        SL.Validate(Type, SL.Type::Item);
        SL.Validate("No.", Rec."No.");
        SL.Validate(Quantity, Rec.Quantity);
        SL.Validate("Unit Price", PriceList."Unit Price");
        SL.Insert();
        if Confirm('Sales Quote No: %1 has been Created, Would you Like to Open It?', true, SH."No.") then
            Page.Run(Page::"Sales Quote", SH);
    end;

    var
        PriceList: Record "Price List Line";
}
