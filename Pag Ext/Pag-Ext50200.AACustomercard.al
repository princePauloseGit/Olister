namespace TasksActivityModule.TasksActivityModule;

using Microsoft.Sales.Customer;
using Microsoft.CRM.Contact;
using Microsoft.CRM.BusinessRelation;
using Microsoft.Projects.Project.Job;
using Microsoft.Inventory.Item;
using Microsoft.CRM.Task;
using Microsoft.CRM.Interaction;
using Microsoft.Purchases.Vendor;

pageextension 50200 "AACustomer card" extends "Customer Card"
{
    layout
    {
        movebefore("No."; Name)
        movebefore("Phone No."; ContactDetails)
        moveafter(Address; "Address 2", City, Control10, "Country/Region Code", "Post Code")
        addafter("Privacy Blocked")

        {
            field("Type"; Rec."Type")
            {
                ApplicationArea = All;
                Caption = 'Customer Type';
                ToolTip = 'Specifies the type of customer.';
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                Caption = 'Status';
                ToolTip = 'Specifies the status of the customer.';
            }
            field(Category; Rec.Category)
            {
                ApplicationArea = All;
                Caption = 'Category';
                ToolTip = 'Specifies the category of the customer.';
            }
        }
        addafter("Salesperson Code")
        {
            field("Account Manager"; Rec."Account Manager")
            {
                ApplicationArea = All;
                Caption = 'Account Manager';
                ToolTip = 'Specifies the Account Manager for the customer.';
            }
        }

        addafter("Home Page")
        {
            field("Company Reg. No."; Rec."Company Reg. No.")
            {
                ApplicationArea = All;
                Caption = 'Company Reg. No.';
                ToolTip = 'Specifies the Company Registration Number for the customer.';
            }
            field("NCAGE Code"; Rec."NCAGE Code")
            {
                ApplicationArea = All;
                Caption = 'NCAGE Code';
                ToolTip = 'Specifies the NCAGE Code for the customer.';
            }
            field("Duns No."; Rec."Duns No.")
            {
                ApplicationArea = All;
                Caption = 'DUNS No';
                ToolTip = 'Specifies the DUNS Number for the customer.';
            }
        }
        modify("Attached Documents List")
        {
            Visible = false;
        }
        movebefore("Primary Contact No."; ContactName)
        modify(Blocked)
        {
            Visible = false;
        }

        modify("Salesperson Code")
        {
            Caption = 'Account Manager';
        }

        modify("Country/Region Code")
        {
            Caption = 'Country / Region';
            ToolTip = 'To change the Country/Region, you must change the Country/Region Code.';
        }
        addbefore("Country/Region Code")
        {
            field("Country/Region"; Rec."Country/Region")
            {
                ApplicationArea = All;
                Caption = 'Country / Region Name';
                ToolTip = 'To change the country/region name, you must change the Country/Region Code.';
                Editable = false;
            }
        }
        modify(ContactName)
        {
            Visible = true;
            ToolTip = 'Specifies the Primary Contact Name. Click on the name to open the Contact details';
            // DrillDown = true;


            trigger OnDrillDown()
            var
                ContactRec: Record Contact;
                Page_ContactCard: Page "Contact Card";
            begin
                Clear(ContactRec);
                if ContactRec.Get(Rec."Primary Contact No.") then begin
                    Page_ContactCard.SetRecord(ContactRec);
                    Page_ContactCard.RunModal();
                end else
                    Message('No Contact found for this Customer.');
            end;
        }

        modify("Primary Contact No.")
        {
            ToolTip = 'Click on [...] near Contact Code to change the Primary Contact for this customer';
            Visible = true;
        }
        addafter("E-Mail")
        {
            field("CGE-Mail"; Rec."CGE-Mail")
            {
                ApplicationArea = All;
                Caption = 'E-Mail';
                ToolTip = 'Specifies an alternate e-mail address for the customer.';
            }
        }
        modify("E-Mail")
        {
            Visible = false;
        }

        addafter(MobilePhoneNo)
        {
            field("CGMobilePhoneNo"; Rec.CGMobilePhone)
            {
                ApplicationArea = All;
                Caption = 'Mobile Phone No.';
                ToolTip = 'Specifies an alternate mobile phone number for the customer.';
            }
        }
        modify(MobilePhoneNo)
        {
            Visible = false;
        }
        // {
        //     field(ContactCode; Rec."Contact Code")
        //     {
        //         ApplicationArea = All;
        //         Caption = 'Contact';
        //         ToolTip = 'Specifies the contact person for the customer. Use the lookup to select a contact from the contact list.';
        //         Editable = false;
        //         trigger OnLookup(var Text:Text[250])
        //         var
        //             Rec_Contact: Record Contact;
        //             Rec_ContactBusinessRelation: Record "Contact Business Relation";
        //             Rec_Contact2: Record Contact;
        //         begin
        //             LookupContactListExt();
        //         end;
        //     }
        // }
        addBefore("Attached Documents List")
        {
            part(Activity1; "Activity List Part FactBox")
            {
                UpdatePropagation = Both;
                Caption = 'Related Activity';
                ApplicationArea = All;
                SubPageLink = "Record No." = field("No."), "Table Name" = const('Customer');
            }
        }
        // addafter(ContactName)
        // {
        //     field("First Name"; Rec."First Name")
        //     {
        //         ApplicationArea = All;
        //         Caption = 'First Name';
        //         ToolTip = 'Specifies the first name of the customer contact.';
        //     }
        //     field("Middle Name"; Rec."Middle Name")
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the middle name of the customer contact.';
        //     }
        //     field(Surname; Rec.Surname)
        //     {
        //         ApplicationArea = All;
        //         ToolTip = 'Specifies the Surname of the customer contact.';
        //     }
        // }


        addafter(Statistics)
        {
            group(Financialinformation)
            {
                Caption = 'Financial Information';
                field(AABlocked; Rec.Blocked)
                {
                    ApplicationArea = All;
                    Caption = 'Blocked Status';
                    ToolTip = 'Specifies the blocked status of the customer.';
                    Editable = false;
                }
            }
        }
        // moveafter(AABlocked; "Balance (LCY)")
        // {

        // }
        // moveafter(Balance (LCY); "Credit Limit (LCY)")
        // {

        // }

        movefirst(Financialinformation; "Balance (LCY)")
        moveafter("Balance (LCY)"; "Credit Limit (LCY)")
        moveafter("Credit Limit (LCY)"; "IC Partner Code")
        moveafter("IC Partner Code"; BalanceAsVendor)
        moveafter(BalanceAsVendor; "Privacy Blocked")
        moveafter("Privacy Blocked"; "Service Zone Code")
        moveafter("Service Zone Code"; "Responsibility Center")
        moveafter("Responsibility Center"; TotalSales2)
        moveafter(TotalSales2; "Document Sending Profile")
        moveafter("Document Sending Profile"; "CustSalesLCY - CustProfit - AdjmtCostLCY")
        moveafter("CustSalesLCY - CustProfit - AdjmtCostLCY"; AdjCustProfit)
        moveafter(AdjCustProfit; AdjProfitPct)
        moveafter(AdjProfitPct; "Balance Due")
        moveafter("Balance Due"; "Balance Due (LCY)")

        movelast(Financialinformation; "Last Date Modified")
        movelast(Financialinformation; "Disable Search by Name")

        addlast(General)
        {
            field("Last Interaction"; Rec."Last Interaction")
            {
                Caption = 'Last Interaction';
                Editable = false;
                ApplicationArea = All;

                DrillDown = true;
                trigger OnDrillDown()
                var
                    Rec_Interaction: Record "Interaction Log Entry";
                begin
                    Rec_Interaction.Reset();
                    Rec_Interaction.SetFilter("Contact No.", '%1', Rec."Primary Contact No.");
                    if Rec_Interaction.FindFirst() then
                        PAGE.Run(PAGE::"Interaction Log Entries", Rec_Interaction);
                end;
            }
        }

        modify(Control149)
        {
            Caption = 'Company Picture';
        }
    }
    actions
    {
        addafter("&Customer")
        {
            group("Activity")
            {

                Caption = 'Activities';
                action(CreateActivity)
                {
                    Caption = 'Create an Activity';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        TasksController: Codeunit "Tasks & Activity Controller";
                    begin
                        TasksController.CreateActivity(Rec."No.", Rec.TableName);
                    end;
                }

            }

            // group("IssueRegister")
            // {

            //     Caption = 'Issue Register';
            //     action(RegisterIssue)
            //     {
            //         Caption = 'Register an Issue';
            //         ApplicationArea = all;
            //         trigger OnAction()
            //         var
            //             TasksController: Codeunit "Tasks & Activity Controller";
            //         begin
            //             TasksController.Registerissue(Rec."No.", Rec.TableName);
            //         end;
            //     }
            // }
            group(Companies)
            {
                action(Customers)
                {
                    Caption = 'Customers';
                    ApplicationArea = all;
                    Image = Customer;
                    RunObject = page "Customer List";
                    //  RunPageLink= 
                }
                action(Vendors)
                {
                    Caption = 'Vendors';
                    ApplicationArea = all;
                    Image = Vendor;
                    RunObject = page "Vendor List";
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
                    RunPageLink = status = filter("Job Status"::"Shipping & Delivery");
                }
                action(AwaitsCustomer)
                {
                    Caption = 'Awaiting Customer';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = status = filter("Job Status"::"Awaits Customer");
                }
                action(Tenders)
                {
                    Caption = 'Tenders';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = status = filter("Job Status"::Tenders);
                }
                action(Research)
                {
                    Caption = 'Research';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = status = filter("Job Status"::Research);
                }
                action("Materials&Parts")
                {
                    Caption = 'Materials & Parts';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = status = filter("Job Status"::"Materials & Parts");
                }
                action(Terminology)
                {
                    Caption = 'Terminology';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = status = filter("Job Status"::Terminology);
                }
                action(Closed)
                {
                    Caption = 'Closed';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = status = filter("Job Status"::Completed);
                }
                action(AllProjects)
                {
                    Caption = 'All Projects';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                }
            }
            group(Activities)
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
            action(Products)
            {
                Caption = 'Related Items';
                ApplicationArea = all;
                Image = Item;
                // RunObject = page "Item List";
                trigger OnAction()
                var
                    ItemRec: Record Item;
                    JobRec: Record Job;
                    FilterItems: Text;
                begin
                    Clear(FilterItems);
                    JobRec.SetFilter("Item No", '<>%1', '');
                    JobRec.SetFilter("Sell-to Customer No.", Rec."No.");
                    if JobRec.FindSet() then begin
                        repeat
                            if FilterItems = '' then
                                FilterItems := JobRec."Item No"
                            else
                                FilterItems := FilterItems + '|' + JobRec."Item No";
                        until JobRec.Next() = 0;
                    end;

                    if FilterItems <> '' then begin
                        ItemRec.SetFilter("No.", FilterItems);
                        Page.Run(Page::"Item List", ItemRec);
                    end else
                        Message('No items found for this Customer in Projects.');
                end;
            }
            action(AllItems)
            {
                Caption = 'All Items';
                ApplicationArea = all;
                Image = Item;
                RunObject = page "Item List";
            }
        }

        addfirst(Promoted)
        {
            actionref(CreateTask_Promoted; CreateActivity)
            {
            }
            // actionref(RegisterIssue_Promoted; RegisterIssue)
            // {
            // }
            group(Companies_Promoted)

            {
                Image = Company;
                Caption = 'Companies';
                actionref(Customer_Promoted; Customers)
                { }
                actionref(Vendor_Promoted; Vendors)
                { }
            }
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
                { }
                actionref(Enquiry_MaterialsAndParts_Promoted; "Enquiry_MaterialsAndParts")
                { }
                actionref(Enquiry_Terminology_Promoted; "Enquiry_Terminology")
                { }
                actionref(Enquiry_AwaitsCustomer_Promoted; "Enquiry_AwaitsCustomer")
                { }
                actionref(Enquiry_Closed_Promoted; "Enquiry_Closed")
                { }


            }
            group(Items)
            {
                actionref(Products_Promoted; Products)
                { }
                actionref(AllItems_Promoted; "AllItems")
                { }
            }

        }

    }

    trigger OnAfterGetRecord()
    var
        Rec_Interaction: Record "Interaction Log Entry";
    begin

        Rec_Interaction.Reset();
        Rec_Interaction.SetRange("Contact No.", Rec."Primary Contact No.");
        if Rec_Interaction.FindLast() then
            Rec."Last Interaction" := Rec_Interaction.SystemCreatedAt
        else
            Rec."Last Interaction" := 0DT;

    end;

    procedure LookupContactListExt()
    var
        ContactBusinessRelation: Record "Contact Business Relation";
        ContactForLookup: Record Contact;
        TempCustomer: Record Customer temporary;
        IsHandled: Boolean;
    begin
        ContactForLookup.FilterGroup(2);
        if ContactBusinessRelation.FindByRelation(ContactBusinessRelation."Link to Table"::Customer, Rec."No.") then
            ContactForLookup.SetRange("Company No.", ContactBusinessRelation."Contact No.")
        else
            ContactForLookup.SetRange("Company No.", '');

        if Rec."Primary Contact No." <> '' then
            if ContactForLookup.Get(Rec."Primary Contact No.") then;
        Page.RunModal(0, ContactForLookup)
    end;
}