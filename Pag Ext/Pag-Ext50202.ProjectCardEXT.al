namespace TasksActivityModule.TasksActivityModule;

using Microsoft.Projects.Project.Job;
using Microsoft.Sales.Customer;
using Microsoft.CRM.Task;
using Microsoft.Inventory.Item;
using System.Security.User;
using System.Utilities;
using Microsoft.Inventory.Item.Picture;
using Microsoft.Purchases.Vendor;
using ChilternGlobalBC.ChilternGlobalBC;
using Microsoft.Sales.Document;
using Microsoft.Pricing.PriceList;
using Microsoft.Purchases.Document;


pageextension 50202 "Project Card EXT" extends "Job Card"
{

    layout
    {
        //hiding Groups
        modify("WIP and Recognition")
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }


        movebefore("No."; Description)
        //add New Fields
        addafter("No.")
        {
            field("Item No"; Rec."Item No")
            {
                TableRelation = Item;
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    Cod: Codeunit "Tasks & Activity Controller";
                begin
                    Cod.OpenItemRecord(Rec."Item No");
                end;
            }
            field(Quantity; Rec.Quantity)
            {
                ApplicationArea = all;
            }
            field("Enquiry No."; Rec."Enquiry No")
            {
                Editable = false;
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    Cod: Codeunit "Tasks & Activity Controller";
                begin
                    Cod.OpenEnquiryRecord(Rec."Enquiry No");
                end;
            }

            field("Project Image"; Rec."Project Image")
            {
                ApplicationArea = all;
                ToolTip = 'Specifies the image of the project.';

                trigger OnValidate()
                var
                    TempBlob: Codeunit "Temp Blob";
                begin
                    CurrPage.SaveRecord();
                end;
            }
        }
        modify("Project Manager")
        {
            Caption = 'Owner';
        }
        modify("Ending Date")
        {
            Caption = 'Due Date';
        }
        addafter("Project Manager")
        {
            field(Originator; Rec.Originator)
            {
                ToolTip = 'Specifies the value of the Originator field.', Comment = '%';
                TableRelation = "User Setup";
                ApplicationArea = all;
            }

            field("Product Type"; Rec."Product Type") { Importance = Additional; ApplicationArea = all; }
            field("Product Category"; Rec."Product Category") { Importance = Additional; ApplicationArea = all; }
            field("Product Group"; Rec."Product Group") { Importance = Additional; ApplicationArea = all; }
            field("Product Range"; Rec."Product Range") { Importance = Additional; ApplicationArea = all; }
        }
        addafter(Blocked)
        {
            field("Item status"; Rec."Item status")
            {
                ApplicationArea = all;
                Caption = 'Item Status';
                ToolTip = 'Specifies the status of the project.';
                Importance = Standard;
            }
            field("Review Date"; Rec."Review Date")
            {
                ApplicationArea = all;
            }
        }
        moveafter(Blocked; status)
        addafter(JobTaskLines)
        {
            group("Vendor Details")
            {
                Caption = 'Vendor Details';
                group("Project Vendors")
                {
                    part(ProjectVendors; "Project Vendor Subform")
                    {
                        ApplicationArea = all;
                        Caption = 'Project Vendors';
                        SubPageLink = "Project No" = field("No.");

                    }
                }
            }
        }
        modify("Job Details")
        {
            Visible = false;
        }

        addfirst(factboxes)
        {
            part(ItemPicture; "Item Picture")
            {
                ApplicationArea = all;
                Caption = 'Item Picture';
                SubPageLink = "No." = field("Item No");
            }
            part("Project Navigation Factbox"; "Project Navigation Factbox")
            {
                ApplicationArea = all;
                Caption = 'Project Navigation';
                SubPageLink = "No." = field("No.");
            }
            part(Activity1; "Activity List Part FactBox")
            {
                UpdatePropagation = Both;
                Caption = 'Project Activity';
                ApplicationArea = All;
                SubPageLink = "Project No." = field("No."), "Table Name" = const('Job');
            }

            part(DocAttachmentFactbox; "Doc Attachment FactBox")
            {
                UpdatePropagation = Both;
                Caption = 'Attachment Upload';
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(Database::Job), "Document No." = field("No.");
                //Attachments Through Activity Only
                Visible = false;
            }
            part(ALLDocAttachmentFactbox; "All Attachments Factbox")
            {
                UpdatePropagation = Both;
                Caption = 'Full Attachment List';
                ApplicationArea = All;
            }

        }
        modify("Attached Documents List")
        {
            Visible = false;
        }

        //Add Projects List After Tasks
        addafter(Duration)
        {
            part("Job Cost Factbox"; "Job Cost Factbox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = field("No.");
            }
        }

    }
    actions
    {

        //Hiding Actions
        modify(Category_Category5)
        {
            Visible = false;
        }
        modify(Category_Category8)
        {
            Visible = false;
        }
        modify("Create Inventory Pick_Promoted")
        {
            Visible = false;
        }
        modify("Create Warehouse Pick_Promoted")
        {
            Visible = false;
        }

        addfirst(Promoted)
        {

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
            group(projects_Promoted)
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
                actionref(Completed_Promoted; Completed)
                { }
            }
            group(Activities_Promoted)
            {
                Caption = 'Activity';
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
            actionref(Products_Promoted; Products)
            { }
        }
        addafter(CreatePurchaseOrder)

        {
            action(CreateSalesQuote)
            {
                Image = NewSalesQuote;
                Caption = 'Create Sales Quote';
                ApplicationArea = all;
                trigger OnAction()
                var
                    PriceListLineSelection: Page "Price List Line Selection";
                begin
                    if Rec."Item status" <> Rec."Item status"::"Work In Progress" then
                        Error('Item Status Must Be Ready For Production');
                    if Rec."Item No" = '' then
                        Error('Item No. Cannot Be Blank');
                    PriceList.SetFilter("Project No.", Rec."No.");
                    PriceList.SetFilter("Product No.", Rec."Item No");
                    PriceList.SetRange("Price Type", PriceList."Price Type"::Sale);
                    PriceList.SetFilter("Source No.", Rec."Bill-to Customer No.");
                    if PriceList.FindSet() then begin
                        if Confirm('Would you like to create a Sales Quote for Customer:%1', true, Rec."Bill-to Customer No.") then
                            CreateSalesQuote();
                    end
                    else
                        Message('No Sales Price List Found for this Project');
                end;
            }
        }
        //add New Actions
        addafter("&Job")
        {
            group("Activity")
            {

                Caption = 'Activity';
                action(CreateActivity)
                {
                    Caption = 'Create an Activity';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        TasksController: Codeunit "Tasks & Activity Controller";
                    begin
                        TasksController.CreateActivityForProject(Rec."No.", Rec.TableName, Rec."Enquiry No");
                    end;
                }

            }
            group("IssueRegister")
            {

                Caption = 'Issue Register';
                action(RegisterIssue)
                {
                    Caption = 'Register an Issue';
                    ApplicationArea = all;
                    trigger OnAction()
                    var
                        TasksController: Codeunit "Tasks & Activity Controller";
                    begin
                        TasksController.Registerissue(Rec."No.", Rec.TableName);
                    end;
                }
            }
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
                action(Completed)
                {
                    Caption = 'Completed';
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
            group(Activities)
            {
                Image = ReleaseDoc;
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
                Caption = 'Products';
                ApplicationArea = all;
                Image = Item;
                RunObject = page "Item List";
            }
        }

        addlast(Promoted)
        {
            group("AANActivity")
            {
                Caption = 'Activity';

            }
            group("Register Issue")
            {
                Caption = 'Register Issue';

            }
        }
    }

    var
        PriceList: Record "Price List Line";

    //Triggers
    trigger OnAfterGetCurrRecord()

    begin
        CurrPage.ALLDocAttachmentFactbox.Page.LoadFromBlob(Rec."No.", Database::Job);

    end;


    procedure UpdateAttachmentMetadataProject(ProjectNo: Code[20]; DocTypeText: Text; DocNo: Code[20]; FileName: Text; ID: Integer)
    var
        AttachmentList: List of [Text];
        BufferRec: Record "All Doc Info Buffer";
        Project: Record Job;
        InStream: InStream;
        OutStream: OutStream;
        SerializedText: Text;
        Line: Text;
        LineText: Text;

    begin
        if not Project.Get(ProjectNo) then
            exit;
        // Clear(Enquiry."Doc Attachment List");

        Project.CalcFields("Doc Attachment List");
        if Project."Doc Attachment List".HasValue then begin
            Project."Doc Attachment List".CreateInStream(InStream);
            InStream.ReadText(SerializedText);
            AttachmentList := SerializedText.Split('¶');
        end;

        LineText := StrSubstNo('%1|%2|%3|%4', DocTypeText, DocNo, FileName, ID);
        AttachmentList.Add(LineText);

        SerializedText := '';
        foreach Line in AttachmentList do
            //message(Line);
            SerializedText += Line + '¶';

        Project."Doc Attachment List".CreateOutStream(OutStream);
        OutStream.Write(SerializedText);

        Project.Modify();
    end;

    local procedure CreateSalesQuote()
    var
        SH: Record "Sales Header";
        SL: Record "Sales Line";
        Project: Record Job;

    begin
        SH.Validate("Document Type", SH."Document Type"::Quote);
        SH.validate("posting date", today);
        SH.validate("Sell-to Customer No.", Rec."Sell-to Customer No.");
        SH.Insert(true);
        SH.Validate("Your Reference", Rec."No." + SH."No.");
        SH.Modify();
        SL.Init();
        SL."Document No." := SH."No.";
        SL.Validate("Document Type", SL."Document Type"::Quote);
        SL.Validate(Type, SL.Type::Item);
        SL.Validate("No.", Rec."Item No");
        SL.Validate(Quantity, Rec.Quantity);
        SL.Validate("Unit Price", PriceList."Unit Price");
        SL.Insert();
        if Confirm('Sales Quote No: %1 has been Created, Would you Like to Open It?', true, SH."No.") then
            Page.Run(Page::"Sales Quote", SH);
    end;

}

