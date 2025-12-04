namespace TasksActivityModule.TasksActivityModule;

using Microsoft.Projects.Project.Job;

page 50265 "Activity Details Navigation"
{
    ApplicationArea = All;
    Caption = 'Activity Details Navigation';
    PageType = CardPart;
    SourceTable = AANActivity;

    layout
    {
        area(Content)
        {
            cuegroup(General)
            {
                Caption = 'General';
                ShowCaption = false;
                field("Related Documents"; GetDocumentCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Related Documents';
                    DrillDownPageID = "Doc Attachment History List";
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        DocAttachHistory: Record "Doc Attachment History";
                    begin
                        DocAttachHistory.SetRange("Table ID", Database::AANActivity);
                        DocAttachHistory.SetRange("Document No.", Rec."Activity No");
                        Page.Run(Page::"Doc Attachment History List", DocAttachHistory);
                    end;
                }
                field("Related Issues"; GetRelatedIssueCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Related Issues';
                    DrillDownPageID = "Issues List";
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        IssueRegister: Record "Issue Register";
                    begin
                        if Rec."Related Issue No" <> '' then begin
                            IssueRegister.SetRange("Issue No", Rec."Related Issue No");
                            Page.Run(Page::"Issues List", IssueRegister);
                        end;
                    end;
                }
                field("Project Activities"; GetProjectActivityCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Project Activities';
                    DrillDownPageID = "AANActivity List";
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        Activity: Record AANActivity;
                    begin
                        if Rec."Project No." <> '' then begin
                            Activity.SetRange("Project No.", Rec."Project No.");
                            Page.Run(Page::"AANActivity List", Activity);
                        end;
                    end;
                }
                field("Enquiry Activities"; GetEnquiryActivityCount())
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Enquiry Activities';
                    DrillDownPageID = "AANActivity List";
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        Activity: Record AANActivity;
                    begin
                        if Rec."Enquiry No." <> '' then begin
                            Activity.SetRange("Enquiry No.", Rec."Enquiry No.");
                            Page.Run(Page::"AANActivity List", Activity);
                        end;
                    end;
                }
            }
        }
    }

    local procedure GetDocumentCount(): Integer
    var
        DocAttachHistory: Record "Doc Attachment History";
    begin
        DocAttachHistory.SetRange("Table ID", Database::AANActivity);
        DocAttachHistory.SetRange("Document No.", Rec."Activity No");
        exit(DocAttachHistory.Count);
    end;

    local procedure GetRelatedIssueCount(): Integer
    var
        IssueRegister: Record "Issue Register";
    begin
        if Rec."Related Issue No" <> '' then begin
            IssueRegister.SetRange("Issue No", Rec."Related Issue No");
            exit(IssueRegister.Count);
        end;
        exit(0);
    end;

    local procedure GetProjectActivityCount(): Integer
    var
        Activity: Record AANActivity;
    begin
        if Rec."Project No." <> '' then begin
            Activity.SetRange("Project No.", Rec."Project No.");
            exit(Activity.Count);
        end;
        exit(0);
    end;

    local procedure GetEnquiryActivityCount(): Integer
    var
        Activity: Record AANActivity;
    begin
        if Rec."Enquiry No." <> '' then begin
            Activity.SetRange("Enquiry No.", Rec."Enquiry No.");
            exit(Activity.Count);
        end;
        exit(0);
    end;
}