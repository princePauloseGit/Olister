namespace TasksActivityModule.TasksActivityModule;
using System.Reflection;
using Microsoft.Projects.Project.Job;
using Microsoft.Purchases.Vendor;
using Microsoft.Sales.Customer;
using System.Security.AccessControl;

page 50205 "Issue Card"
{
    ApplicationArea = All;
    Caption = 'Issue Card';
    PageType = Card;
    SourceTable = "Issue Register";
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {

                Caption = 'General';

                field("Issue No"; Rec."Issue No")
                {
                    ToolTip = 'Specifies the value of the Task No field.', Comment = '%';
                    Editable = false;
                }

                field("Project No."; Rec."Project No.")
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Cod: Codeunit "Tasks & Activity Controller";
                    begin
                        case rec."Table Name" of
                            'Job':
                                Cod.OpenProjectRecord(Rec."Project No.");
                        end;
                    end;
                }
                field("Project Name"; Rec."Project Name")
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Cod: Codeunit "Tasks & Activity Controller";
                    begin
                        case rec."Table Name" of
                            'Job':
                                Cod.OpenProjectRecord(Rec."Project No.");
                        end;
                    end;
                }
                field("Enquiry No."; Rec."Enquiry No.")
                {
                    Editable = false;

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
                        Cod: Codeunit "Tasks & Activity Controller";
                    begin
                        Cod.OpenEnquiryRecord(Rec."Enquiry No.");
                    end;
                }
                field("Activity No."; Rec."Activity No.")
                {
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        Cod: Codeunit "Tasks & Activity Controller";
                    begin

                        Cod.OpenActivityRecord(Rec."Activity No.");
                    end;


                }
                field("Activity Name"; Rec."Activity Name")
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Cod: Codeunit "Tasks & Activity Controller";
                    begin

                    end;
                }
            }
            group(Details)
            {
                field("Project Owner"; Rec."Project Owner")
                {
                    ToolTip = 'Specifies the value of the Project Owner field.', Comment = '%';
                    Editable = false;
                }
                field("Issue Owner"; Rec."Issue Owner")
                {
                    ToolTip = 'Specifies the value of the Issue Owner field.', Comment = '%';
                    Editable = false;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        customer: Record Customer;
                    begin
                        if customer.Get(Rec."CustomerNo.") then
                            Run(page::"Customer Card", customer)
                    end;
                }
                field("CustomerNo."; Rec."CustomerNo.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                    Editable = false;
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
                    ToolTip = 'Specifies the value of the Vendor Name field.', Comment = '%';
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Vendor: Record Vendor;
                    begin
                        if Vendor.Get(Rec."VendorNo") then
                            Run(page::"Vendor Card", Vendor)
                    end;
                }
                field(VendorNo; Rec.VendorNo)
                {
                    ToolTip = 'Specifies the value of the Vendor No. field.', Comment = '%';
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Vendor: Record Vendor;
                    begin
                        if Vendor.Get(Rec."VendorNo") then
                            Run(page::"Vendor Card", Vendor)
                    end;
                }
            }
            group(ComplianceIssue)
            {
                Caption = 'Compliance Issue';
                group(Compliance)
                {
                    Caption = 'Compliance Issue Details';
                    field(ComplianceIssueText; G_ComplianceIssueText)
                    {
                        MultiLine = true;
                        Caption = 'Compliance Issue';
                        ApplicationArea = All;
                        trigger OnValidate()
                        var
                            users: Record User;
                        begin
                            SetComplianceText(G_ComplianceIssueText);
                            Rec.ComplianceIssueCreatedBy := UserId;
                            Rec.ComplianceIssueDate := CurrentDateTime;
                        end;
                    }
                    field(ComplianceIssueCreatedBy; Rec.ComplianceIssueCreatedBy)
                    {
                        ApplicationArea = All;
                    }
                    field(ComplianceIssueDate; Rec.ComplianceIssueDate)
                    {
                        ApplicationArea = All;
                    }
                }
                group(ComplinaceIssueNotes)
                {
                    Caption = 'Compliance Issue Notes Details';
                    field(ComplianceIssueNotes; G_ComplianceIssueNotes)
                    {
                        MultiLine = true;
                        Caption = 'Compliance Issue Notes';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            SetComplianceNotes(G_ComplianceIssueNotes);
                            Rec.ComplianceIssueNotesCreatedBy := UserId;
                            Rec."Compliance Issue Notes Date" := CurrentDateTime;
                        end;
                    }
                    field(ComplianceIssueNotesCreatedBy; Rec.ComplianceIssueNotesCreatedBy)
                    {
                        ApplicationArea = All;
                    }
                    field("Compliance Issue Notes Date"; Rec."Compliance Issue Notes Date")
                    {
                        ApplicationArea = All;
                    }
                }
            }
            group(RootCause)
            {
                Caption = 'Root Cause';
                group(RootCauseDetails)
                {
                    Caption = 'Root Cause Details';
                    field(G_RootCauseText; G_RootCauseText)
                    {
                        MultiLine = true;
                        Caption = 'Root Cause';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            SetRootCauseText(G_RootCauseText);
                            Rec."Root Cause Created By" := UserId;
                            Rec."Root Cause Date" := CurrentDateTime;
                        end;
                    }
                    field("Root Cause Created By"; Rec."Root Cause Created By")
                    {
                        ApplicationArea = All;
                    }
                    field("Root Cause Date"; Rec."Root Cause Date")
                    {
                        ApplicationArea = All;
                    }
                }
                group(RootCauseNotes)
                {
                    Caption = 'Root Cause Notes Details';

                    field(G_RootCauseNotes; G_RootCauseNotes)
                    {
                        MultiLine = true;
                        Caption = 'Root Cause Notes';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            SetRootCauseNotesText(G_RootCauseNotes);
                            Rec."Root Cause Notes Created By" := UserId;
                            Rec."Root Cause Notes Date" := CurrentDateTime;
                        end;
                    }
                    field("Root Cause Notes Created By"; Rec."Root Cause Notes Created By")
                    {
                        ApplicationArea = All;
                    }
                    field("Root Cause Notes Date"; Rec."Root Cause Notes Date")
                    {
                        ApplicationArea = All;
                    }

                }
            }
            group(CorrectiveActions)
            {
                Caption = 'Corrective Action';
                group(CorrectiveActionsDetails)
                {
                    Caption = 'Corrective Action Details';
                    field(G_CorrectiveActionText; G_CorrectiveActionText)
                    {
                        MultiLine = true;
                        Caption = 'Corrective Action';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            SetCorrectiveActionText(G_CorrectiveActionText);
                            Rec."CorrectiveAction Created By" := UserId;
                            Rec."CorrectiveAction Date" := CurrentDateTime;
                        end;
                    }
                    field("CorrectiveAction Created By"; Rec."CorrectiveAction Created By")
                    {
                        ApplicationArea = All;
                    }
                    field("CorrectiveAction Date"; Rec."CorrectiveAction Date")
                    {
                        ApplicationArea = All;
                    }
                }
                group(CorrectiveActionsNotesDetails)
                {
                    Caption = 'Corrective Action Notes Details';
                    field(G_CorrectiveActionNotes; G_CorrectiveActionNotes)
                    {
                        MultiLine = true;
                        Caption = 'Corrective Actions Notes';
                        ApplicationArea = All;
                        trigger OnValidate()
                        begin
                            SetCorrectiveActionNotesText(G_CorrectiveActionNotes);
                            Rec.CorrectiveActionNotesCreatedBy := UserId;
                            Rec."CorrectiveAction Notes Date" := CurrentDateTime;
                        end;
                    }
                    field(CorrectiveActionNotesCreatedBy; Rec.CorrectiveActionNotesCreatedBy)
                    {
                        ApplicationArea = All;
                    }
                    field("CorrectiveAction Notes Date"; Rec."CorrectiveAction Notes Date")
                    {
                        ApplicationArea = All;
                    }

                }
            }
        }
        area(FactBoxes)
        {
            part(DocAttachmentFactbox; "Doc Attachment FactBox")
            {
                UpdatePropagation = Both;
                Caption = 'Attachment Upload';
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(Database::AANActivity), "Document No." = field("Activity No.");
            }


        }

    }


    // actions
    // {
    //  
    //     area(Promoted)
    //     {
    //         group(createaTask)
    //         {
    //             Caption = 'Create Task';

    //             actionref(AssignTask_Promoted; CreateTask)
    //             {
    //             }
    //         }
    //     }
    // }
    trigger OnAfterGetRecord()
    begin
        G_ComplianceIssueText := GetComplianceText();
        G_ComplianceIssueNotes := GetComplianceNotes();
        G_RootCauseText := GetRootCauseText();
        G_RootCauseNotes := GetRootCauseNotesText();
        G_CorrectiveActionText := GetCorrectiveActionText();
        G_CorrectiveActionNotes := GetCorrectiveActionNotesText();

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

    procedure SetComplianceNotes(NewLargeText: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec.ComplianceIssueNotes);
        Rec.ComplianceIssueNotes.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(G_ComplianceIssueNotes);
        Rec.Modify();
    end;

    procedure GetComplianceNotes() NewLargeText: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields(ComplianceIssueNotes);
        Rec.ComplianceIssueNotes.CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName(ComplianceIssueNotes)));
    end;

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

    procedure SetRootCauseNotesText(L_Ctext: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec.RootCauseNotes);
        Rec.RootCauseNotes.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(G_RootCauseNotes);
        Rec.Modify();
    end;

    procedure GetRootCauseNotesText() NewLargeText: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields(RootCauseNotes);
        Rec.RootCauseNotes.CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName(RootCauseNotes)));
    end;

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

    procedure SetCorrectiveActionNotesText(L_Ctext: Text)
    var
        OutStream: OutStream;
    begin
        Clear(Rec.CorrectiveActionNotes);
        Rec.CorrectiveActionNotes.CreateOutStream(OutStream, TEXTENCODING::UTF8);
        OutStream.WriteText(G_CorrectiveActionNotes);
        Rec.Modify();
    end;

    procedure GetCorrectiveActionNotesText() NewLargeText: Text
    var
        TypeHelper: Codeunit "Type Helper";
        InStream: InStream;
    begin
        Rec.CalcFields(CorrectiveActionNotes);
        Rec.CorrectiveActionNotes.CreateInStream(InStream, TEXTENCODING::UTF8);
        exit(TypeHelper.TryReadAsTextWithSepAndFieldErrMsg(InStream, TypeHelper.LFSeparator(), Rec.FieldName(CorrectiveActionNotes)));
    end;


    var
        G_ComplianceIssueText: Text;
        G_ComplianceIssueNotes: Text;
        G_RootCauseText: Text;
        G_RootCauseNotes: Text;
        G_CorrectiveActionText: Text;
        G_CorrectiveActionNotes: Text;


}
