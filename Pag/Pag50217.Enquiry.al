namespace TasksActivityModule.TasksActivityModule;
using Microsoft.Projects.Project.Job;
using Microsoft.Foundation.Attachment;
using System.Reflection;
using System.Security.User;
using Microsoft.Inventory.Item.Picture;
using Microsoft.Purchases.Vendor;
using Microsoft.Inventory.Item;
using Microsoft.Sales.Customer;
using Microsoft.Sales.Document;
using ChilternGlobalBC.ChilternGlobalBC;

page 50217 Enquiry
{
    ApplicationArea = All;
    Caption = 'Enquiry';
    PageType = Card;
    SourceTable = Enquiry;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Enquiry No."; Rec."Enquiry No.")
                {
                    ToolTip = 'Specifies the value of the Enquiry No. field.', Comment = '%';
                    Editable = false;
                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = all;
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                    Editable = false;
                }
                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                    trigger OnValidate()
                    var
                        EnquiryProjects: Record Job;
                    begin
                        if Rec."Customer No." <> xRec."Customer No." then begin
                            EnquiryProjects.SetFilter("Enquiry No", Rec."Enquiry No.");
                            if enquiryProjects.FindSet() then
                                Error('Cannot change Customer No. as there are linked Projects to this Enquiry. Please remove linked Projects before changing the Customer.');
                        end;
                    end;
                }

                field("Review Date"; Rec."Review Date")
                {

                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the status field.', Comment = '%';
                }
                field(Owner; Rec.Owner)
                {
                    ToolTip = 'Specifies the value of the Owner field.', Comment = '%';
                }
                field(Originator; Rec.Originator)
                {
                    ToolTip = 'Specifies the value of the Originator field.', Comment = '%';
                    TableRelation = "User Setup";
                }




            }
            group("Customer Details")
            {
                ShowCaption = false;
                field("Customer Address"; Rec."Customer Address")
                {
                    ToolTip = 'Specifies the value of the Customer Address field.', Comment = '%';
                }
                field("Customer Email"; Rec."Customer Email")
                {
                    ToolTip = 'Specifies the value of the Customer Email field.', Comment = '%';
                }
                field("Customer Phone Number"; Rec."Customer Phone Number")
                {
                    ToolTip = 'Specifies the value of the Tel field.', Comment = '%';
                }
            }
            group(LinkedProjects)
            {
                Caption = 'Projects';
                part("Project List"; "Projects ListPart factbox")
                {
                    ApplicationArea = Basic, Suite;

                    SubPageLink = "Enquiry No" = field("Enquiry No.");

                }
            }


        }
        area(FactBoxes)
        {

            part(Activity1; "Activity List Part FactBox")
            {
                UpdatePropagation = Both;
                Caption = 'Related Activity';
                ApplicationArea = All;
                SubPageLink = "Record No." = field("Enquiry No."), "Table Name" = const('Enquiry');

            }
            Part(EnquiryNavFactbox; "Enquiry Navigation Factbox")
            {
                Caption = 'Enquiry Navigation';
                ApplicationArea = All;
                SubPageLink = "Enquiry No." = field("Enquiry No.");
            }

            // part(attach; "Doc Attachment FactBox")
            // {
            //     Caption = 'Enquiry Attachments';
            //     SubPageLink = "Table ID" = const(Database::Enquiry),
            //          "Document No." = field("Enquiry No.");
            // }
            part("Customer Activity"; "Activity List Part FactBox")
            {
                Caption = 'Customer Activity';
                ApplicationArea = all;
                SubPageLink = "Record No." = field("Customer No."), "Table Name" = const('Customer');
            }
            part(ALLDocAttachmentFactbox; "All Attachments Factbox")
            {
                UpdatePropagation = Both;
                Caption = 'Full Attachment List';
                ApplicationArea = All;
            }

            systempart(Links; Links)
            {
                ApplicationArea = all;
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = all;
                Visible = true;
            }
        }

    }
    actions
    {
        area(Creation)
        {

            action(CreateActivity)
            {
                Caption = 'Create an Activity';
                ApplicationArea = all;
                trigger OnAction()
                begin
                    TasksController.CreateActivity(Rec."Enquiry No.", Rec.TableName);
                end;
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
                action(Suppliers)
                {
                    Caption = 'Suppliers';
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
        }
        area(Promoted)
        {
            actionref(CreateActivity_Promoted; CreateActivity)
            { }
            group(Companies_Promoted)

            {
                Image = Company;
                Caption = 'Companies';
                actionref(Customer_Promoted; Customers)
                { }
                actionref(Vendor_Promoted; Suppliers)
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
            actionref(Products_Promoted; Products)
            { }
        }


    }
    trigger OnAfterGetCurrRecord()
    var
        "Document No.": Text;
        Project: Record Job;
        Activity: Record AANActivity;
    begin
        CurrPage.ALLDocAttachmentFactbox.Page.LoadFromBlob(Rec."Enquiry No.", Database::Enquiry);
    end;

    procedure UpdateAttachmentMetadataEnquiry(EnquiryNo: Code[20]; DocTypeText: Text; DocNo: Code[20]; FileName: Text; ID: Integer)
    var
        AttachmentList: List of [Text];
        BufferRec: Record "All Doc Info Buffer";
        Enquiry: Record Enquiry;
        InStream: InStream;
        OutStream: OutStream;
        SerializedText: Text;
        Line: Text;
        LineText: Text;

    begin
        if not Enquiry.Get(EnquiryNo) then
            exit;

        Enquiry.CalcFields("Doc Attachment List");
        if Enquiry."Doc Attachment List".HasValue then begin
            Enquiry."Doc Attachment List".CreateInStream(InStream);
            InStream.ReadText(SerializedText);
            AttachmentList := SerializedText.Split('¶');
        end;

        LineText := StrSubstNo('%1|%2|%3|%4', DocTypeText, DocNo, FileName, ID);
        AttachmentList.Add(LineText);

        SerializedText := '';
        foreach Line in AttachmentList do
            SerializedText += Line + '¶';

        Enquiry."Doc Attachment List".CreateOutStream(OutStream);
        OutStream.Write(SerializedText);

        Enquiry.Modify();
    end;

    procedure DeleteAttachmentMetadataEnquiry(EnquiryNo: Code[20]; ID: Integer)
    var
        Enquiry: Record Enquiry;
        InStream: InStream;
        OutStream: OutStream;
        SerializedText: Text;
        AttachmentList: List of [Text];
        Line: Text;
        Parts: List of [Text];
        CleanedText: Text;
        i: Integer;
    begin
        if not Enquiry.Get(EnquiryNo) then
            exit;

        Enquiry.CalcFields("Doc Attachment List");
        if not Enquiry."Doc Attachment List".HasValue then
            exit;

        // Read blob into text
        Enquiry."Doc Attachment List".CreateInStream(InStream);
        InStream.ReadText(SerializedText);

        AttachmentList := SerializedText.Split('¶');

        // Loop and find the matching line by ID
        for i := 1 to AttachmentList.Count do begin
            Line := AttachmentList.Get(i);
            if Line <> '' then begin
                Parts := Line.Split('|');
                if Parts.Count >= 4 then begin
                    if Parts.Get(4) = Format(ID) then begin
                        AttachmentList.RemoveAt(i);
                        break;
                    end;
                end;
            end;
        end;

        // Rebuild text without the deleted line
        CleanedText := '';
        foreach Line in AttachmentList do
            if Line <> '' then
                CleanedText += Line + '¶';

        // Update blob
        Clear(Enquiry."Doc Attachment List");
        Enquiry."Doc Attachment List".CreateOutStream(OutStream);
        OutStream.Write(CleanedText);

        Enquiry.Modify();
    end;

    var
        TasksController: Codeunit "Tasks & Activity Controller";

}


