namespace TasksActivityModule.TasksActivityModule;
using Microsoft.Sales.Customer;
using Microsoft.Projects.Project.Job;
using ChilternGlobalBC.ChilternGlobalBC;
using System.Utilities;
using Microsoft.Foundation.Reporting;
using Microsoft.Inventory.Item;
using Microsoft.Projects.Project.Planning;
using Microsoft.Purchases.Vendor;
using Microsoft.Purchases.History;
using System.Email;

codeunit 50200 "Tasks & Activity Controller"
{
    procedure CreateActivityForProject(AARecord: Code[20]; AATableName: Text[30]; AAEnquiryNo: Code[20])
    var
        Activity: Record AANActivity;
        Job: Record Job;
    begin
        Job.Get(AARecord);
        Activity.Init();
        Activity.Validate("Project No.", AARecord);
        Activity.Validate("Record No.", AARecord);
        Activity.Validate("Table Name", AATableName);
        Activity.Validate("Enquiry No.", AAEnquiryNo);
        Activity.Validate("Customer No.", Job."Sell-to Customer No.");
        Activity.Validate("Item No.", Job."Item No");
        Activity.Validate("Item Variant", Job."Item Variant");
        Activity.Insert(true);
        Page.Run(50201, Activity);
    end;

    procedure CreateActivity(AARecord: Code[20]; AATableName: Text[30])
    var
        Activity: Record AANActivity;

    begin
        Activity.Init();
        Activity.Validate("Record No.", AARecord);
        if AATableName = 'Enquiry' then
            Activity.Validate("Enquiry No.", AARecord);
        Activity.Validate("Table Name", AATableName);
        Activity.Insert(true);
        Page.Run(50201, Activity);
    end;

    procedure CreateActivityFromPlanningLines(PPL: Record "Job Planning Line")
    var
        Activity: Record AANActivity;
        project: Record Job;
    begin
        if project.Get(PPL."Job No.") then begin
            Activity.Init();
            Activity.Validate("Record No.", PPL."Job No.");
            Activity.Validate("Enquiry No.", project."Enquiry No");
            Activity.Validate("Table Name", PPL.TableName);
            Activity.Validate("Project No.", PPL."Job No.");
            Activity.Validate("Project Task No.", PPL."Job Task No.");
            Activity.Validate("Project Planning Line No", PPL."Line No.");
            Activity.Insert(true);
            Page.Run(50201, Activity);
        end;

    end;

    // procedure CreateActivityFromVendor(AARecord: Code[20]; AATableName: Text[30])
    // var
    //     Activity: Record AANActivity;

    // begin
    //     Activity.Init();
    //     Activity.Validate("Vendor No.", AARecord);
    //     // Activity.Validate("Record No.", AARecord);
    //     Activity.Validate("Table Name", AATableName);
    //     Activity.Insert(true);
    //     Page.Run(50201, Activity);
    // end;

    procedure CreateTaskFromissue(AAIssue: Code[20]; AARecord: Code[20]; AATableName: Text[30])
    var
        Activity: Record AANActivity;

    begin
        Activity.Init();
        // Activity.Validate("Project No.", AARecord);
        Activity.Validate("Record No.", AARecord);
        Activity.Validate("Table Name", AATableName);
        Activity.Validate("Related Issue No", AAIssue);
        Activity.Insert(true);
        Page.Run(50201, Activity);
    end;

    procedure Registerissue(AARecord: Code[20]; AATableName: Text[30])
    var
        Issue: Record "Issue Register";

    begin
        Issue.Init();
        Issue.Validate("Record ID", AARecord);
        Issue.Validate("Table Name", AATableName);
        if AATableName = 'Vendor' then
            Issue.Validate(VendorNo, AARecord)
        else if AATableName = 'Customer' then
            Issue.Validate("CustomerNo.", AARecord);
        Issue.Insert(true);
        Page.Run(50205, Issue);
    end;

    procedure RegisterissueFromActivity(var AAIssue: Code[20]; Activity: Record AANActivity)
    var
        Issue: Record "Issue Register";
        Project: Record Job;
    begin
        Issue.Init();
        Issue.Validate("Record ID", Activity."Record No.");
        Issue.Validate("Table Name", Activity."Table Name");
        Issue.Validate("Project No.", Activity."Project No.");
        Issue.Validate("Activity No.", Activity."Activity No");
        IF Project.Get(Activity."Project No.") THEN
            Issue.Validate(VendorNo, Project."Vendor No.");
        Issue.Validate("CustomerNo.", Activity."Customer No.");
        case Activity."Table Name" of
            'Vendor':
                Issue.Validate(VendorNo, Activity."Record No.");
            'Customer':
                Issue.Validate("CustomerNo.", Activity."Record No.");
        end;
        Issue.Validate("Enquiry No.", Activity."Enquiry No.");
        //SM21/07
        Issue.Insert(true);
        AAIssue := Issue."Issue No";
        Page.Run(50205, Issue);
    end;

    procedure CreateStaff(AARecord: Code[20]; AATableName: Text[30])
    var
        Staff: Record "Staff Details";

    begin
        Staff.Init();
        Staff.Validate("Related No.", AARecord);
        Staff.Validate("Table Name", AATableName);
        Staff.Insert(true);
        Page.Run(50228, Staff);
    end;

    procedure OpenCustomerRecord(RecordId: code[20])
    var
        "Cust": Page "Customer Card";
        Custtable: Record Customer;

    begin
        if RecordId <> '' then begin
            Custtable.Get(RecordId);
            "Cust".SetRecord(Custtable);
            "Cust".Run();
        end;
    end;

    procedure OpenEnquiryRecord(EnquiryNo: code[20])
    var
        "Enquiry": Page Enquiry;
        Enq: Record Enquiry;

    begin
        if EnquiryNo <> '' then begin
            Enq.Get(EnQuiryNo);
            "Enquiry".SetRecord(Enq);
            "Enquiry".Run();
        end;
    end;

    procedure OpenItemRecord(ItemNo: code[20])
    var
        "Item Card": Page "Item Card";
        Item: Record Item;

    begin
        if ItemNo <> '' then begin
            Item.Get(ItemNo);
            "Item Card".SetRecord(Item);
            "Item Card".Run();
        end;
    end;


    procedure OpenVendorRecord(RecordId: code[20])
    var
        "Vend": Page "Vendor Card";
        Vendtable: Record Vendor;

    begin
        if RecordId <> '' then begin
            Vendtable.Get(RecordId);
            "Vend".SetRecord(Vendtable);
            "Vend".Run();
        end;
    end;

    procedure OpenProjectRecord(RecordId: code[20])
    var
        "Job": Page "Job Card";
        Jobtable: Record Job;

    begin
        if RecordId <> '' then begin
            Jobtable.Get(RecordId);
            "Job".SetRecord(Jobtable);
            "Job".Run();
        end;
    end;

    procedure OpenIssueRecord(RecordId: code[20])
    var
        "Issue": Page "Issue Card";
        RecIssue: Record "Issue Register";

    begin
        if RecordId <> '' then begin
            RecIssue.Get(RecordId);
            "Issue".SetRecord(RecIssue);
            "Issue".Run();
        end;
    end;

    procedure OpenActivityRecord(RecordId: code[20])
    var
        "Activity": Page "Activity Card";
        RecActivity: Record AANActivity;

    begin
        if RecordId <> '' then begin
            RecActivity.Get(RecordId);
            "Activity".SetRecord(RecActivity);
            "Activity".Run();
        end;
    end;

    procedure CreateProject("Enquiry No": Code[20]; Customer: Code[20]; "Item No.": Code[20]; Description: Text[250]; Quantity: Decimal): Code[20]
    var
        Project: Record Job;
    begin
        Project.Init();
        Project.Validate("No.");
        Project.Validate("Enquiry No", "Enquiry No");
        Project.Validate("Sell-to Customer No.", Customer);
        Project.Validate("Item No", "Item No.");
        Project.Validate(Description, Description);
        Project.Validate(Quantity, Quantity);
        Project.Insert(true);
        exit(Project."No.");
    end;

    Procedure SendEmail(Var Activity: Record AANActivity): Text
    var
        Email: Codeunit Email;
        EmailMessage: Codeunit "Email Message";
        EmailScenario: Enum "Email Scenario";
        Body: Text;
        EmailOutbox: Record "Email Outbox";
        ActURL: Text;
    begin
        ActURL := GetUrl(ClientType::Web, CompanyName, ObjectType::Page, Page::"Activity Card", Activity, false);
        Body := StrSubstNo('<p>Hello,</p><p>Activity No: %1</p><p><a href="' + ActURL + '" target="_blank">Open Activity</a></p><p>Thanks and have a great day!</p>', Activity."Activity No");
        EmailMessage.Create('', 'Email Confirmation ' + Activity."Activity No", Body, true);
        AddAttachmentToActivityEmail(EmailMessage, Activity);
        Email.OpenInEditor(EmailMessage);


        // if Email.Send(EmailMessage, EmailScenario::Default) then
        //     Message('Email sent successfully')
        // else
        //     Error('Could not send email. Please check your email configuration.');
    end;



    local procedure AddAttachmentToActivityEmail(var EmailMessage: Codeunit "Email Message"; Activity: Record AANActivity)
    var
        //ReportLayoutSelection: Record "Report Layout Selection";
        TempBlob: Codeunit "Temp Blob";
        ActivityRecordRef: RecordRef;
        ReportInStream: InStream;
        ReportOutStream: OutStream;
        LayoutCode: Code[20];
        ReportId: Integer;
        AttachmentFileNameLbl: Label 'Activity %1.pdf', Comment = '%1 Activity No.';
    begin
        TempBlob.CreateOutStream(ReportOutStream);
        ActivityRecordRef := SetActivityRecordRef(Activity);
        //    ReportLayoutSelection := GetPurchInvoiceReportandLayoutCode(ReportId, LayoutCode);

        Report.SaveAs(Report::"Activity Details", '', ReportFormat::Pdf, ReportOutStream, ActivityRecordRef);

        TempBlob.CreateInStream(ReportInStream);
        EmailMessage.AddAttachment(StrSubstNo(AttachmentFileNameLbl, Activity."Activity No"), '', ReportInStream);
    end;

    procedure SetActivityRecordRef(Activity: Record AANActivity) ReturnRecordRef: RecordRef
    var

        ActivityRecord: Record AANActivity;
    begin
        ActivityRecord.SetRange("Activity No", Activity."Activity No");
        ActivityRecord.Findfirst();
        ReturnRecordRef.GetTable(ActivityRecord);
    end;

    // procedure GetPurchInvoiceReportandLayoutCode(var ReportId: Integer; var LayoutCode: Code[20]) ReportLayoutSelection: Record "Report Layout Selection"
    // var
    //     Reportselections: Record "Report Selections";
    // begin
    //     Reportselections.Reset();
    //     Reportselections.SetRange(Usage, Reportselections.Usage::"P.Invoice");
    //     Reportselections.SetRange("Use for Email Attachment", true);
    //     if Reportselections.Findfirst() then begin
    //         LayoutCode := Reportselections."Email Body Layout Code";
    //         ReportId := Reportselections."Report ID";
    //         if ReportLayoutSelection.Get(ReportId, CompanyName) then;
    //     end;
    // end;


}
