page 50219 "Doc Attachment FactBox"
{
    PageType = ListPart;
    SourceTable = "Doc Attachment History";
    Caption = 'Attachments Upload';
    ApplicationArea = All;
    InsertAllowed = false;
    ModifyAllowed = false;
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Selection: Integer;
                        RecDocAttachment: Record "Document Attachment";

                    begin
                        RecDocAttachment.Get(Rec."Table ID", Rec."Document No.", rec."Document Type", rec."Line No.", Rec.ID);

                        if DMSCodeunit.SupportedByFileViewer(RecDocAttachment) then
                            DMSCodeunit.ViewFile(RecDocAttachment, Rec)
                        else
                            DMSCodeunit.Export(true, RecDocAttachment)
                    end;
                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;
                }
                field("Date and Time"; Rec."Date and Time")
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            fileuploadaction(Upload)
            {
                ApplicationArea = All;
                Caption = 'Upload';
                AllowMultipleFiles = true;
                trigger OnAction(Files: List of [FileUpload])
                var
                    // DocHistory: Record "Doc Attachment History";
                    pagefgfgh: Page "Doc Attachment Card";
                begin
                    UploadFile(Files);
                    GDocuHistory.SetRange("Entry No.", Int1, Int2);
                    if GDocuHistory.FindSet() then begin
                        pagefgfgh.getdata(GDocuHistory);
                        pagefgfgh.RunModal()
                        // if PAGE.RunModal(PAGE::"Doc Attachment Card", GDocuHistory) = Action::LookupOK then begin
                        // end;
                    end;
                end;
            }
            action(OpenDMS)
            {
                ApplicationArea = All;
                Caption = 'Open Document Management System List';
                RunObject = page "Doc Attachment History List";
            }

        }
    }
    var
        Int1: Integer;
        Int2: Integer;
        DMSCodeunit: Codeunit "DocAttach Ask Metadata";
        GDocuHistory: Record "Doc Attachment History";

    procedure UploadFile(Files: List of [FileUpload])
    var
        FileName: Text;
        UploadStream: InStream;
        DocumentAttachment: Record "Document Attachment";
        FileMgmt: Codeunit "File Management";
        History: Record "Doc Attachment History";
        EnqPage: Page Enquiry;
        EnqRec: Record Enquiry;
        Act: Record AANActivity;
        ProjectRec: Record Job;
        ProjectPage: Page "Job Card";
        FileUpload: FileUpload;
    begin
        foreach FileUpload in Files do begin
            FileUpload.CreateInStream(UploadStream);

            if FileUpload.FileName <> '' then begin
                Clear(DocumentAttachment);
                Clear(History);
                DocumentAttachment.Init();
                DocumentAttachment."Table ID" := Rec."Table ID";
                DocumentAttachment."No." := Rec."Document No.";
                DocumentAttachment."Line No." := Rec."Line No.";
                DocumentAttachment."Document Type" := Rec."Document Type";
                DocumentAttachment."File Name" := FileMgmt.GetFileNameWithoutExtension(FileUpload.FileName);
                DocumentAttachment."File Extension" := FileMgmt.GetExtension(FileUpload.FileName);
                DocumentAttachment.ImportFromStream(UploadStream, FileUpload.FileName);
                DocumentAttachment.Insert(true);


                History.Init();
                History.ID := DocumentAttachment.ID;
                History."Table ID" := DocumentAttachment."Table ID";
                History."Line No." := DocumentAttachment."Line No.";
                History."Document No." := DocumentAttachment."No.";
                History."File Name" := DocumentAttachment."File Name";
                History."User ID" := UserId;
                History."Date and Time" := CurrentDateTime;
                History.Insert();
                case History."Table ID" of
                    Database::AANActivity:
                        begin
                            if Act.Get(History."Document No.") then begin
                                if Act."Enquiry No." <> '' then
                                    EnqPage.UpdateAttachmentMetadataEnquiry(Act."Enquiry No.", 'Activity', History."Document No.", History."File Name", History."Entry No.");
                                if Act."Project No." <> '' then
                                    ProjectPage.UpdateAttachmentMetadataProject(Act."Project No.", 'Activity', History."Document No.", History."File Name", History."Entry No.");
                            end;

                        end;
                    Database::Job:
                        begin
                            if ProjectRec.Get(History."Document No.") then begin
                                if ProjectRec."No." <> '' then
                                    ProjectPage.UpdateAttachmentMetadataProject(ProjectRec."No.", 'Project', History."Document No.", History."File Name", History."Entry No.");
                                if ProjectRec."Enquiry No" <> '' then
                                    EnqPage.UpdateAttachmentMetadataEnquiry(ProjectRec."Enquiry No", 'Project', History."Document No.", History."File Name", History."Entry No.");
                            end;
                        end;
                    Database::Enquiry:
                        begin
                            EnqRec.Get(History."Document No.");
                            EnqPage.UpdateAttachmentMetadataEnquiry(EnqRec."Enquiry No.", 'Enquiry', History."Document No.", History."File Name", History."Entry No.");
                        end;
                end;

                GDocuHistory := History;
                If Int1 = 0 then
                    Int1 := History."Entry No.";
                Int2 := History."Entry No.";
                Commit();
            end else
                Message('Please select a valid file.');
        end;

    end;
    // procedure FilterSubData(FilterValue: Text)
    // begin
    //     Rec.SetFilter("Document No.", FilterValue);
    //     CurrPage.Update(false);
    // end;

}