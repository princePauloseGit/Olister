namespace TasksActivityModule.TasksActivityModule;
using System.Reflection;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Customer;

page 50204 "Issues List"
{
    ApplicationArea = All;
    Caption = 'Issue Register';
    PageType = List;
    SourceTable = "Issue Register";
    UsageCategory = Lists;
    CardPageId = 50205;
    ModifyAllowed = false;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'Date Created';
                }
                field("Issue No"; Rec."Issue No")
                {
                    ToolTip = 'Specifies the value of the Issue No field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        myInt: Integer;
                    begin

                    end;
                }
                field(ComplianceIssueText; G_ComplianceIssueText)
                {
                    Caption = 'Compliance Issue';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SetComplianceText(G_ComplianceIssueText);

                    end;
                }
                // field(ComplianceIssueCreatedBy; Rec.ComplianceIssueCreatedBy)
                // {
                //     ApplicationArea = All;
                // }
                // field(ComplianceIssueDate; Rec.ComplianceIssueDate)
                // {
                //     ApplicationArea = All;
                // }
                // field(ComplianceIssueNotes; G_ComplianceIssueNotes)
                // {
                //     Caption = 'Compliance Issue Notes';
                //     ApplicationArea = All;
                //     trigger OnValidate()
                //     begin
                //         SetComplianceNotes(G_ComplianceIssueNotes);
                //     end;
                // }
                // field(ComplianceIssueNotesCreatedBy; Rec.ComplianceIssueNotesCreatedBy)
                // {
                //     ApplicationArea = All;
                // }
                // field("Compliance Issue Notes Date"; Rec."Compliance Issue Notes Date")
                // {
                //     ApplicationArea = All;
                // }
                field(G_RootCauseText; G_RootCauseText)
                {
                    Caption = 'Root Cause';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SetRootCauseText(G_RootCauseText);

                    end;
                }
                // field("Root Cause Created By"; Rec."Root Cause Created By")
                // {
                //     ApplicationArea = All;
                // }
                // field("Root Cause Date"; Rec."Root Cause Date")
                // {
                //     ApplicationArea = All;
                // }
                // field(G_RootCauseNotes; G_RootCauseNotes)
                // {
                //     Caption = 'Root Cause Notes';
                //     ApplicationArea = All;
                //     trigger OnValidate()
                //     begin
                //         SetRootCauseNotesText(G_RootCauseNotes);
                //     end;
                // }
                // field("Root Cause Notes Created By"; Rec."Root Cause Notes Created By")
                // {
                //     ApplicationArea = All;
                // }
                // field("Root Cause Notes Date"; Rec."Root Cause Notes Date")
                // {
                //     ApplicationArea = All;
                // }

                field(G_CorrectiveActionText; G_CorrectiveActionText)
                {
                    Caption = 'Corrective Action';
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        SetCorrectiveActionText(G_CorrectiveActionText);

                    end;
                }
                // field("CorrectiveAction Created By"; Rec."CorrectiveAction Created By")
                // {
                //     ApplicationArea = All;
                // }
                // field("CorrectiveAction Date"; Rec."CorrectiveAction Date")
                // {
                //     ApplicationArea = All;
                // }
                // field(G_CorrectiveActionNotes; G_CorrectiveActionNotes)
                // {
                //     Caption = 'Corrective Actions Notes';
                //     ApplicationArea = All;
                //     trigger OnValidate()
                //     begin
                //         SetCorrectiveActionNotesText(G_CorrectiveActionNotes);
                //     end;
                // }
                // field(CorrectiveActionNotesCreatedBy; Rec.CorrectiveActionNotesCreatedBy)
                // {
                //     ApplicationArea = All;
                // }
                // field("CorrectiveAction Notes Date"; Rec."CorrectiveAction Notes Date")
                // {
                //     ApplicationArea = All;
                // }

                field("Project Name"; Rec."Project Name")
                {

                }
                field("Project No."; Rec."Project No.")
                {

                }
                // field("Project No. Name"; G_ProjectNoName)
                // {
                //     Caption = 'Project Details';
                //     ApplicationArea = All;
                // }
                field("Enquiry Name"; Rec."Enquiry Name")
                {

                }
                field("Enquiry No."; Rec."Enquiry No.")
                {

                }
                // field("Enquiry No. Name"; G_EnquiryNoName)
                // {
                //     Caption = 'Enquiry Details';
                //     ApplicationArea = All;
                // }
                field("Customer Name"; Rec."Customer Name")
                {
                    trigger OnDrillDown()
                    var
                        customer: Record Customer;
                    begin
                        if customer.Get(Rec."CustomerNo.") then
                            Run(page::"Customer Card", customer)
                    end;
                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    trigger OnDrillDown()
                    var
                        Vendor: Record Vendor;
                    begin
                        if Vendor.Get(Rec."VendorNo") then
                            Run(page::"Vendor Card", Vendor)
                    end;
                }
                field("Issue Owner"; Rec."Issue Owner")
                {

                }
                field("Project Owner"; Rec."Project Owner")
                {


                }

                // field("Record ID"; Rec."Record ID")
                // {
                //     ToolTip = 'Specifies the value of the Record ID field.', Comment = '%';
                //     trigger OnDrillDown()
                //     var
                //         Cod: Codeunit "Tasks & Activity Controller";
                //     begin
                //         if rec."Table Name" = 'Customer' then
                //             Cod.OpenCustomerRecord(Rec."Record ID");
                //         if rec."Table Name" = 'Vendor' then
                //             Cod.OpenVendorRecord(Rec."Record ID");
                //         if rec."Table Name" = 'Job' then
                //             Cod.OpenProjectRecord(Rec."Record ID");
                //     end;
                // }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the value of the Priority field.', Comment = '%';
                }


            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        G_ComplianceIssueText := GetComplianceText();
        // G_ComplianceIssueNotes := GetComplianceNotes();
        G_RootCauseText := GetRootCauseText();
        // G_RootCauseNotes := GetRootCauseNotesText();
        G_CorrectiveActionText := GetCorrectiveActionText();
        // G_CorrectiveActionNotes := GetCorrectiveActionNotesText();
        Rec.CalcFields("Project Name", "Enquiry Name");

        G_ProjectNoName := Rec."Project No." + '-' + Rec."Project Name";
        G_EnquiryNoName := Rec."Enquiry No." + '-' + Rec."Enquiry Name";
    end;

    procedure SetComplianceText(L_Ctext: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec.ComplianceIssue);
        Rec.ComplianceIssue.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(G_ComplianceIssueText);
        Rec.Modify();
    end;

    procedure GetComplianceText() NewLargeText: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields(ComplianceIssue);
        Rec.ComplianceIssue.CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName(ComplianceIssue)));
    end;

    // procedure SetComplianceNotes(NewLargeText: Text)
    // var
    //     OutStream: OutStream;
    // begin
    //     Clear(Rec.ComplianceIssueNotes);
    //     Rec.ComplianceIssueNotes.CreateOutStream(OutStream, TEXTENCODING::UTF8);
    //     OutStream.WriteText(G_ComplianceIssueNotes);
    //     Rec.Modify();
    // end;

    // procedure GetComplianceNotes() NewLargeText: Text
    // var  
    //     TypeHelper: Codeunit "Type Helper";
    //     InStream: InStream;
    // begin
    //     Rec.CalcFields(ComplianceIssueNotes);
    //     Rec.ComplianceIssueNotes.CreateInStream(InStream, TEXTENCODING::UTF8);
    //     exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName(ComplianceIssueNotes)));
    // end;

    procedure SetRootCauseText(L_Ctext: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec.RootCause);
        Rec.RootCause.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(G_RootCauseText);
        Rec.Modify();
    end;

    procedure GetRootCauseText() NewLargeText: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields(RootCause);
        Rec.RootCause.CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName(RootCause)));
    end;

    // procedure SetRootCauseNotesText(L_Ctext: Text)
    // var
    //     OutStream: OutStream;
    // begin
    //     Clear(Rec.RootCauseNotes);
    //     Rec.RootCauseNotes.CreateOutStream(OutStream, TEXTENCODING::UTF8);
    //     OutStream.WriteText(G_RootCauseNotes);
    //     Rec.Modify();
    // end;

    // procedure GetRootCauseNotesText() NewLargeText: Text
    // var
    //     TypeHelper: Codeunit "Type Helper";
    //     InStream: InStream;
    // begin
    //     Rec.CalcFields(RootCauseNotes);
    //     Rec.RootCauseNotes.CreateInStream(InStream, TEXTENCODING::UTF8);
    //     exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName(RootCauseNotes)));
    // end;

    procedure SetCorrectiveActionText(L_Ctext: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec.CorrectiveAction);
        Rec.CorrectiveAction.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(G_CorrectiveActionText);
        Rec.Modify();
    end;

    procedure GetCorrectiveActionText() NewLargeText: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields(CorrectiveAction);
        Rec.CorrectiveAction.CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName(CorrectiveAction)));
    end;

    // procedure SetCorrectiveActionNotesText(L_Ctext: Text)
    // var
    //     OutStream: OutStream;
    // begin
    //     Clear(Rec.CorrectiveActionNotes);
    //     Rec.CorrectiveActionNotes.CreateOutStream(OutStream, TEXTENCODING::UTF8);
    //     OutStream.WriteText(G_CorrectiveActionNotes);
    //     Rec.Modify();
    // end;

    // procedure GetCorrectiveActionNotesText() NewLargeText: Text
    // var
    //     TypeHelper: Codeunit "Type Helper";
    //     InStream: InStream;
    // begin
    //     Rec.CalcFields(CorrectiveActionNotes);
    //     Rec.CorrectiveActionNotes.CreateInStream(InStream, TEXTENCODING::UTF8);
    //     exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName(CorrectiveActionNotes)));
    // end;


    var
        G_ComplianceIssueText: Text;
        //     G_ComplianceIssueNotes: Text;
        G_RootCauseText: Text;
        //     G_RootCauseNotes: Text;
        G_CorrectiveActionText: Text;
        //     G_CorrectiveActionNotes: Text;
        G_ProjectNoName: Text[1024];
        G_EnquiryNoName: Text[1024];
}
