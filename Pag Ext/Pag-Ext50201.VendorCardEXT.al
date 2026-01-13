namespace TasksActivityModule.TasksActivityModule;

using Microsoft.Purchases.Vendor;
using Microsoft.CRM.Task;
using ChilternGlobalBC.ChilternGlobalBC;
using Microsoft.Inventory.Item;
using Microsoft.Projects.Project.Job;
using Microsoft.Sales.Customer;
using Microsoft.CRM.Interaction;

pageextension 50201 "Vendor Card EXT" extends "Vendor Card"
{
    layout
    {
        movebefore("No."; Name)
        addafter("No.")
        {
            field("Type"; Rec."Type")
            {
                ApplicationArea = All;
                Caption = 'Vendor Type';
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

        addlast(General)
        {
            field("Last Interaction"; Rec."Last Interaction")
            {
                ApplicationArea = All;
                Caption = 'Last Interaction';
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

        modify("Attached Documents List")
        {
            Visible = false;
        }

        modify("Purchaser Code")
        {
            Caption = 'Account Manager';
        }
        moveafter(Category; "Purchaser Code")
        moveafter("Purchaser Code"; "Last Date Modified")

        addBefore("Attached Documents List")
        {
            part(DocAttachmentFactbox; "Doc Attachment FactBox")
            {
                UpdatePropagation = Both;
                Caption = 'Attachment Upload';
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(Database::AANActivity), "Document No." = field("No.");
                //Attachments Through Activity Only
                Visible = false;
            }
            part(Activity1; "Activity List Part FactBox")
            {
                UpdatePropagation = Both;
                Caption = 'Related Activity';
                ApplicationArea = All;
                SubPageLink = "Record No." = field("No."), "Table Name" = const('Customer');
            }
            part(StaffList; "Staff List")
            {
                UpdatePropagation = Both;
                Caption = 'Staff List';
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
            }

        }

        addafter(Receiving)
        {
            group(FinancialInformation)
            {
                Caption = 'Financial Information';

                field("CGBalance (LCY)"; Rec."Balance (LCY)")
                {
                    ApplicationArea = All;
                    Caption = 'Balance (LCY)';
                    ToolTip = 'Specifies the current balance for the vendor in local currency.';
                }
                field("Balance Due"; Rec."Balance Due")
                {
                    ApplicationArea = All;
                    Caption = 'Balance Due';
                    ToolTip = 'Specifies the balance due for the vendor.';
                }
                field("CGBalance Due (LCY)"; Rec."Balance Due (LCY)")
                {
                    ApplicationArea = All;
                    Caption = 'Balance Due (LCY)';
                    ToolTip = 'Specifies the balance due for the vendor in local currency.';
                }
                field("CGPrivacy Blocked"; Rec."Privacy Blocked")
                {
                    ApplicationArea = All;
                    Caption = 'Privacy Blocked';
                    ToolTip = 'Indicates whether the vendor is blocked for privacy reasons.';

                }
            }
        }


        modify(Blocked)
        {
            Visible = false;
        }

        modify("Balance (LCY)")
        {
            Visible = false;
        }

        // modify("Balance Due")
        // {
        //     Visible = false;
        // }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Privacy Blocked")
        {
            Visible = false;
        }

        movelast(FinancialInformation; "Document Sending Profile")
        movelast(FinancialInformation; "Search Name")
        movelast(FinancialInformation; "IC Partner Code")
        movelast(FinancialInformation; "Responsibility Center")
        movelast(FinancialInformation; "Disable Search by Name")
        movelast(FinancialInformation; "Company Size Code")
        // movelast(FinancialInformation; "Sust. Cert. Name")
        // movelast(FinancialInformation; "Sust. Cert. No.")
        // movelast(FinancialInformation; "Carbon Pricing Paid")
        movelast(FinancialInformation; "Last Date Modified")
        movelast(FinancialInformation; BalanceAsCustomer)

        movebefore("Country/Region Code"; City)
        moveafter(City; County)

        movefirst(Contact; "Our Account No.")
        moveafter("Our Account No."; Control16)
        moveafter(Control16; "Primary Contact No.")

        modify("Primary Contact No.")
        {
            Caption = 'Contact Code';
        }
        moveafter("Primary Contact No."; "Phone No.")
        moveafter("Phone No."; MobilePhoneNo)
        moveafter(MobilePhoneNo; "E-Mail")
        moveafter("E-Mail"; "Fax No.")
        moveafter("Fax No."; "Home Page")


        modify("Our Account No.")
        {
            Caption = 'Chiltern Vendor Account No.';
        }





    }



    actions
    {
        addafter("&Purchases")
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
                    RunPageLink = status = filter("Job Status"::Open);
                }
                action(CustomerOrders)
                {
                    Caption = 'Customer Orders';
                    ApplicationArea = all;
                    RunObject = page "Job List";
                    RunPageLink = status = filter("Job Status"::"Customer Order");
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
                trigger OnAction()
                var
                    ItemRec: Record Item;
                    JobRec: Record Job;
                    FilterItems: Text;
                begin
                    Clear(FilterItems);
                    JobRec.SetFilter("Item No", '<>%1', '');
                    JobRec.SetFilter("Vendor No.", Rec."No.");
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
                        Page.Run(Page::"Item List", ItemRec); // Standard Item List
                    end else
                        Message('No items found for this Vendor in Projects.');
                end;
            }
            action(VendorItems)
            {
                Caption = 'Vendor Items';
                ApplicationArea = all;
                Image = Item;
                RunObject = page "Item List";
                RunPageLink = "Vendor No." = field("No.");
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
                actionref(MaterialsParts_Promoted; "Materials&Parts")
                { }
                actionref(Terminology_Promoted; Terminology)
                { }
                actionref(Closed_Promoted; Closed)
                { }
                actionref(AllProjects_Promoted; AllProjects)
                { }
            }
            group(Activities_Promoted)
            {
                Caption = 'Activities';
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
            group(ItemsGroup)
            {
                Caption = 'Items';
                actionref(Products_Promoted; Products)
                { }
                actionref(AllItems_Promoted; "AllItems")
                { }
                actionref(VendorItems_Promoted; VendorItems)
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

}
