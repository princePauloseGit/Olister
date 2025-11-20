namespace TasksActivityModule.TasksActivityModule;
using Microsoft.Foundation.Attachment;
using System.Security.User;
using System.Security.AccessControl;
using Microsoft.Inventory.Item;
using Microsoft.Purchases.Vendor;
using Microsoft.Projects.Project.Job;
using ChilternGlobalBC.ChilternGlobalBC;
using Microsoft.Projects.Project.Planning;
using Microsoft.Pricing.PriceList;
using Microsoft.Sales.Customer;

page 50201 "Activity Card"
{
    ApplicationArea = All;
    Caption = 'Activity Card';
    PageType = Card;
    SourceTable = AANActivity;
    PopulateAllFields = true;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'Activity Details';

                field("Activity Title"; Rec."Activity Title")
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                    ColumnSpan = 100;
                }
                // field(Description; Rec.Description)
                // {
                //     Caption = 'Description';
                // }
                field("Activity type"; Rec."Activity Type")
                {
                    trigger OnValidate()
                    var
                        L_TaskController: Codeunit "Tasks & Activity Controller";
                        IssueNo: Code[20];
                        ActivityType: Record "Activity Type";
                        ProjectVendor: Record "Project vendors";
                        "Price List": Page "Create Price List";

                    begin
                        if Rec."Activity type" <> '' then begin
                            if ActivityType.Get(Rec."Activity type") then begin
                                case ActivityType."Default Next Step" of
                                    "Activity Next Step"::"Create an Issue":
                                        begin
                                            L_TaskController.RegisterissueFromActivity(IssueNo, Rec);
                                            Rec.Validate("Related Issue No", IssueNo);
                                            Rec.Modify(true);
                                            VisibleBoolean := true
                                        end;
                                    "Activity Next Step"::"Create Purchase Price List":
                                        begin
                                            CanCreateSPL := false;
                                            CanCreatePPL := true;
                                            "Price List".Getdata(Rec, CanCreatePPL, CanCreateSPL);
                                            if "Price List".RunModal() = Action::OK then begin
                                                "Price List".setdata(Rec."Sales Price List code", Rec."Purchase Price List code", Rec."Vendor No.", Rec."Item No.");
                                                SetPriceListEditable();
                                                Rec.Purchase := true;
                                                Rec.Sale := false;
                                            end else
                                                Rec.Validate("Activity type", xRec."Activity type");
                                        end;
                                    "Activity Next Step"::"Create Sales Price List":
                                        begin
                                            CanCreatePPL := false;
                                            CanCreateSPL := true;
                                            "Price List".Getdata(Rec, CanCreatePPL, CanCreateSPL);
                                            if "Price List".RunModal() = Action::OK then begin
                                                "Price List".setdata(Rec."Sales Price List code", Rec."Purchase Price List code", Rec."Vendor No.", Rec."Item No.");
                                                SetPriceListEditable();
                                                Rec.Sale := true;
                                                Rec.Purchase := false;
                                            end
                                            else
                                                Rec.Validate("Activity type", xRec."Activity type");
                                        end;
                                    else
                                        VisibleBoolean := false;
                                end;
                            end;
                        end;
                    end;
                }
                field("Item No."; Rec."Item No.")
                {
                    Editable = false;
                }
                field("Vendor No."; Rec."Vendor No.")
                {
                    Editable = false;
                    Visible = CanCreatePPL;
                    ToolTip = 'Specifies the value of the Vendor No field.', Comment = '%';
                }
                field("Customer No."; Rec."Customer No.")
                {
                    Editable = false;
                    Visible = CanCreateSPL;
                    ToolTip = 'Specifies the value of the Customer No field.', Comment = '%';
                }

                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'Start Date';
                }
                field("Review Date"; Rec."Review Date")
                {
                    ToolTip = 'Specifies the value of the Review Date field.', Comment = '%';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.', Comment = '%';
                }

                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                    Caption = 'Created By';
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ToolTip = 'Specifies the value of the Assigned To field.', Comment = '%';
                    Caption = 'Assigned To';
                    trigger OnValidate()
                    var
                    begin
                        Rec."Assigned Date" := CurrentDateTime;
                    end;
                }
                field("Assigned Date"; Rec."Assigned Date")
                {
                    ToolTip = 'Specifies the value of the Assigned to field.', Comment = '%';
                    Caption = 'Assigned Date';
                }
                field(Accountable; Rec.Accountable)
                {
                    ToolTip = 'Specifies the value of the Accountable field.', Comment = '%';
                    trigger OnValidate()
                    var
                    begin
                        Rec."Accountable Date" := CurrentDateTime;
                    end;
                }
                field("Accountable Date"; Rec."Accountable Date")
                {
                    ToolTip = 'Specifies the value of the Accountable Date field.', Comment = '%';
                    Caption = 'Accountable Date';
                }
                // field("Completed By"; Rec."Completed By")
                // {
                //     ToolTip = 'Specifies the value of the Completed by field.', Comment = '%';
                //     Caption = 'Completed By';
                // }
                // field("completed Date"; Rec."completed Date")
                // {
                //     ToolTip = 'Specifies the value of the completed Date field.', Comment = '%';
                //     // Editable = false;
                //     Caption = 'Completed Date';
                // }
                field(Tags; Rec.Tags)
                {
                    trigger OnAssistEdit()
                    var
                        TagMaster: Record TagMaster;
                        TagPage: Page Tag;
                    begin
                        if Page.RunModal(Page::Tag, TagMaster) = Action::LookupOK then begin
                            Rec."Tags" := TagMaster.Tag;
                        end;
                    end;
                }
            }
            group("Relation")
            {

                field("Record No."; Rec."Record No.")
                {
                    ToolTip = 'Specifies the value of the Record No field.', Comment = '%';
                    Caption = 'No';
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Project: Record Job;
                        Enquiry: Record "Enquiry";
                        Customer: Record Customer;
                        Vendor: Record Vendor;
                    begin
                        case Rec."Table Name" of
                            'Job':
                                begin
                                    Project.Get(Rec."Record No.");
                                    Page.Run(Page::"Job Card", Project);
                                end;
                            'Enquiry':
                                begin
                                    Enquiry.Get(Rec."Record No.");
                                    Page.Run(Page::"Enquiry", Enquiry);
                                end;
                            'Customer':
                                begin
                                    Customer.Get(Rec."Record No.");
                                    Page.Run(Page::"Customer Card", Customer);
                                end;
                            'Vendor':
                                begin
                                    Vendor.Get(Rec."Record No.");
                                    Page.Run(Page::"Vendor Card", Vendor);
                                end;
                        end;
                    end;
                }
                field("Table Name"; Rec."Table Name")
                {
                    ToolTip = 'Specifies the value of the Table Name field.', Comment = '%';
                    Caption = 'Table Name';
                    Editable = false;
                }
            }
            group("Project Details")
            {
                Caption = 'Project Details';


                field("Project No."; Rec."Project No.")
                {
                    Editable = false;
                    Caption = 'Project No';
                    trigger OnDrillDown()
                    var
                        Cod: Codeunit "Tasks & Activity Controller";
                        Job: Record Job;
                    begin
                        case rec."Table Name" of
                            'Job':
                                Cod.OpenProjectRecord(Rec."Project No.");
                        end;
                        if Rec."Project No." <> '' then begin
                            if Job.Get(Rec."Project No.") then
                                Page.Run(Page::"Job Card", Job);
                        end;
                    end;
                }
                field("Job Task No."; Rec."Project Task No.")
                {
                    Editable = false;
                    Visible = FromPlanningLines;
                    trigger OnDrillDown()
                    var
                        JobTask: Record "Job Task";
                    begin
                        if (Rec."Project No." <> '') and (Rec."Project Task No." <> '') then begin
                            if JobTask.Get(Rec."Project No.", Rec."Project Task No.") then
                                Page.Run(Page::"Job Task Card", JobTask);
                        end;
                    end;
                }
                field("Project Planning Line No"; Rec."Project Planning Line No")
                {
                    Editable = false;
                    Visible = FromPlanningLines;
                    trigger OnDrillDown()
                    var
                        JobPlanningLine: Record "Job Planning Line";
                    begin
                        if (Rec."Project No." <> '') and (Rec."Project Task No." <> '') and (Rec."Project Planning Line No" <> 0) then begin
                            if JobPlanningLine.Get(Rec."Project No.", Rec."Project Task No.", Rec."Project Planning Line No") then
                                Page.Run(Page::"Job Planning Lines", JobPlanningLine);
                        end;
                    end;
                }
                field("Project Name"; Rec."Project Name")
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Job: Record Job;
                    begin
                        if Rec."Project No." <> '' then begin
                            if Job.Get(Rec."Project No.") then
                                Page.Run(Page::"Job Card", Job);
                        end;
                    end;
                }
                field("Project Start Date"; Rec."Project Start Date")
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Job: Record Job;
                    begin
                        if Rec."Project No." <> '' then begin
                            if Job.Get(Rec."Project No.") then
                                Page.Run(Page::"Job Card", Job);
                        end;
                    end;
                }
                field("Project End Date"; Rec."Project End Date")
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Job: Record Job;
                    begin
                        if Rec."Project No." <> '' then begin
                            if Job.Get(Rec."Project No.") then
                                Page.Run(Page::"Job Card", Job);
                        end;
                    end;
                }
                field("Related Issue No"; Rec."Related Issue No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the value of the Related Issue No field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        Cod: Codeunit "Tasks & Activity Controller";
                    begin

                        Cod.OpenIssueRecord(Rec."Related Issue No");
                    end;
                }
                field("Project Task No."; Rec."Project Task No.")
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        JobTask: Record "Job Task";
                    begin
                        if (Rec."Project No." <> '') and (Rec."Project Task No." <> '') then begin
                            if JobTask.Get(Rec."Project No.", Rec."Project Task No.") then
                                Page.Run(Page::"Job Task Card", JobTask);
                        end;
                    end;
                }
                field(ProjectPlanningLineNo; Rec."Project Planning Line No")
                {
                    Caption = 'Project Planning Line No';
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        JobPlanningLine: Record "Job Planning Line";
                    begin
                        if (Rec."Project No." <> '') and (Rec."Project Task No." <> '') and (Rec."Project Planning Line No" <> 0) then begin
                            if JobPlanningLine.Get(Rec."Project No.", Rec."Project Task No.", Rec."Project Planning Line No") then
                                Page.Run(Page::"Job Planning Lines", JobPlanningLine);
                        end;
                    end;
                }
            }
            group(Enquiry)
            {
                Caption = 'Enquiry Details';
                field("Enquiry No."; Rec."Enquiry No.")
                {
                    Editable = false;
                    Caption = 'Enqiry No';
                    trigger OnDrillDown()
                    var
                        Cod: Codeunit "Tasks & Activity Controller";
                    begin

                        Cod.OpenEnquiryRecord(Rec."Enquiry No.");
                    end;
                }
                field("Enquiry Name"; Rec."Enquiry Name")
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Enquiry: Record "Enquiry";
                    begin
                        if Rec."Enquiry No." <> '' then begin
                            if Enquiry.Get(Rec."Enquiry No.") then
                                Page.Run(Page::"Enquiry", Enquiry);
                        end;
                    end;
                }
                field("Enquiry Start Date"; Rec."Enquiry Start Date")
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Enquiry: Record "Enquiry";
                    begin
                        if Rec."Enquiry No." <> '' then begin
                            if Enquiry.Get(Rec."Enquiry No.") then
                                Page.Run(Page::"Enquiry", Enquiry);
                        end;
                    end;
                }
                field("Enquiry Due Date"; Rec."Enquiry Due Date")
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Enquiry: Record "Enquiry";
                    begin
                        if Rec."Enquiry No." <> '' then begin
                            if Enquiry.Get(Rec."Enquiry No.") then
                                Page.Run(Page::"Enquiry", Enquiry);
                        end;
                    end;
                }
            }
            group("Issue Details")
            {

                Visible = VisibleBoolean;
                Caption = 'Issue Details';
                field(G_ComplianceIssueText; G_ComplianceIssueText)
                {
                    Caption = 'Compliance Issue';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(G_ComplianceIssueNotes; G_ComplianceIssueNotes)
                {
                    Caption = 'Compliance Issue Notes';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(G_CorrectiveActionText; G_CorrectiveActionText)
                {
                    Caption = 'Corrective Action';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(G_CorrectiveActionNotes; G_CorrectiveActionNotes)
                {
                    Caption = 'Corrective Actions Notes';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(G_RootCauseText; G_RootCauseText)
                {
                    Caption = 'Root Cause';
                    Editable = false;
                    ApplicationArea = all;
                }
                field(G_RootCauseNotes; G_RootCauseNotes)
                {
                    Caption = 'Root Cause Notes';
                    Editable = false;
                    ApplicationArea = all;
                }
            }
            group("Sales Price List Line")
            {

                part("Sales Price List Lines"; "Price List Lines")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = (CanCreateSPL) AND (SalesListVisible);
                    UpdatePropagation = Both;
                    Caption = 'Sales Price List Lines';
                    SubPageLink = "Price List Code" = field("Sales Price List code"), "Project No." = field("Project No."), "Source No." = field("Customer No.");
                }
            }
            group("Purchase Price List Lines")
            {
                part("Purch. Price List Lines"; "Price List Lines")
                {
                    ApplicationArea = all;
                    Visible = (CanCreatePPL) AND (PurchListVisible);
                    Caption = 'Purchase Price List Lines';
                    UpdatePropagation = Both;
                    SubPageView = where("Price Type" = filter("Price Type"::Purchase));
                    SubPageLink = "Price List Code" = field("Purchase Price List code"), "Project No." = field("Project No."), "Source No." = field("Vendor No."), "Price Type" = filter("Price Type"::Purchase);
                }
            }
        }

        area(FactBoxes)
        {
            part(DocAttachmentFactbox;
            "Doc Attachment FactBox")
            {
                UpdatePropagation = Both;
                Caption = 'Attachment Upload';
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(Database::AANActivity), "Document No." = field("Activity No");
            }
            systempart(Links; Links)
            {
                ApplicationArea = all;
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }

    actions
    {
        area(Creation)
        {

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
                Caption = 'Products';
                ApplicationArea = all;
                Image = Item;
                RunObject = page "Item List";
            }
            action(ShareActivity)
            {
                Caption = 'Send Activity';
                ApplicationArea = all;
                Image = Email;
                trigger OnAction()
                var
                    Email: Page "Email Recepient Selection";
                begin
                    Email.GetData(Rec);
                    Page.RunModal(Page::"Email Recepient Selection")
                end;
            }
        }
        area(Promoted)
        {
            group(Companies_Promoted)

            {
                Image = Company;
                Caption = 'Companies';
                actionref(Customer_Promoted; Customers)
                { }
                actionref(Vendor_Promoted; Vendors)
                { }
            }
            actionref(ShareActivity_Promoted; ShareActivity) { }
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
            actionref(Products_Promoted; Products)
            { }
        }


    }
    var
        CanCreateSPL: Boolean;
        CanCreatePPL: Boolean;
        FromPlanningLines: Boolean;
        PurchListVisible: Boolean;
        SalesListVisible: Boolean;
        VisibleBoolean: Boolean;
        G_ComplianceIssueText: Text;
        G_ComplianceIssueNotes: Text;
        G_RootCauseText: Text;
        G_RootCauseNotes: Text;
        G_CorrectiveActionText: Text;
        G_CorrectiveActionNotes: Text;
        InStrCompliance: InStream;
        InStrNotes: InStream;
        InStrRootCause: InStream;
        InStrRootCauseNotes: InStream;
        InStrCorrectiveAction: InStream;
        InStrCorrectiveActionNotes: InStream;
        NewViewAmountType: Enum "Price Amount Type";
        NewPriceType: Enum "Price Type";
        "ItemNo": Code[20];




    trigger OnAfterGetCurrRecord()
    var
        "User Setup": Record "User Setup";
        NewViewAmountType: Enum "Price Amount Type";
        RecIssue: Record "Issue Register";
        ActivityType: Record "Activity Type";
    begin
        if Rec."Table Name" = 'Job Planning Line' then
            FromPlanningLines := true;
        if Rec."Activity type" <> '' then begin
            ActivityType.Get(Rec."Activity type");

            if ActivityType."Default Next Step" = "Activity Next Step"::"Create Sales Price List" then
                CanCreateSPL := true
            else
                CanCreateSPL := false;

            if ActivityType."Default Next Step" = "Activity Next Step"::"Create Purchase Price List" then
                CanCreatePPL := true
            else
                CanCreatePPL := false;
        end;




        if "User Setup".Get(UserId) then begin
            if "User Setup"."Project Purch. List access" = true then begin
                PurchListVisible := true;
            end
            else
                PurchListVisible := false;
            if "User Setup"."Project Sales List access" = true then begin
                SalesListVisible := true;
            end else
                SalesListVisible := false;
        end;

        if ActivityType."Default Next Step" = "Activity Next Step"::"Create an Issue" then
            VisibleBoolean := true else
            VisibleBoolean := false;

        if RecIssue.Get(Rec."Related Issue No") then begin
            RecIssue.CalcFields(
                ComplianceIssue, ComplianceIssueNotes, RootCause, RootCauseNotes, CorrectiveAction, CorrectiveActionNotes);
            RecIssue.ComplianceIssue.CreateInStream(InStrCompliance, TEXTENCODING::UTF8);
            InStrCompliance.ReadText(G_ComplianceIssueText);

            RecIssue.ComplianceIssueNotes.CreateInStream(InStrNotes, TEXTENCODING::UTF8);
            InStrNotes.ReadText(G_ComplianceIssueNotes);

            RecIssue.RootCause.CreateInStream(InStrRootCause, TEXTENCODING::UTF8);
            InStrRootCause.ReadText(G_RootCauseText);

            RecIssue.RootCauseNotes.CreateInStream(InStrRootCauseNotes, TEXTENCODING::UTF8);
            InStrRootCauseNotes.ReadText(G_RootCauseNotes);

            RecIssue.CorrectiveAction.CreateInStream(InStrCorrectiveAction, TEXTENCODING::UTF8);
            InStrCorrectiveAction.ReadText(G_CorrectiveActionText);

            RecIssue.CorrectiveActionNotes.CreateInStream(InStrCorrectiveActionNotes, TEXTENCODING::UTF8);
            InStrCorrectiveActionNotes.ReadText(G_CorrectiveActionNotes);
        end;
        SetPriceListEditable();
        CurrPage.Update();
    end;


    procedure SetPriceListEditable()
    var
        priceList: Record "Price List Header";
    begin
        if Rec.Sale then begin
            CurrPage."Sales Price List Lines".Page.SetSubFormLinkFilter(NewViewAmountType::Any);
            CurrPage."Sales Price List Lines".Page.SetPriceType("Price Type"::Sale);
            if priceList.Get(Rec."Sales Price List code") then
                CurrPage."Sales Price List Lines".Page.SetHeader(priceList);
        end
        else if Rec.Purchase then begin
            CurrPage."Purch. Price List Lines".Page.SetSubFormLinkFilter(NewViewAmountType::Any);
            CurrPage."Purch. Price List Lines".Page.SetPriceType("Price Type"::Purchase);
            if priceList.Get(Rec."Purchase Price List code") then
                CurrPage."Purch. Price List Lines".Page.SetHeader(priceList);
        end;

    end;

}
