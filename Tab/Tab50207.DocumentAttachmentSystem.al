table 50207 "Doc Attachment History"
{
    Caption = 'Document Attachment History';
    DataClassification = CustomerContent;
    LookupPageId = 50214;
    DrillDownPageId = 50214;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            AutoIncrement = true;
            DataClassification = CustomerContent;
        }
        field(2; "Table ID"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(5; ID; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(6; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(7; "Date and Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Document Purpose"; Text[1024])
        {
            DataClassification = CustomerContent;
        }
        field(9; "Document Tag"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Document Type"; Enum "Attachment Document Type")
        {
            DataClassification = CustomerContent;
        }
        field(11; "File Name"; Text[250])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Document Attachment"."File Name"
                where("Table ID" = field("Table ID"),
                      "No." = field("Document No."),
                      "Line No." = field("Line No."),
                      ID = field(ID)));
        }
        field(12; "Table Name"; Text[30])
        {
            Caption = 'Table Name';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.", ID, "Line No.", "Table ID", "Document No.") { }
    }
    trigger OnDelete()
    var
        EnqRec: Record Enquiry;
        EnqPage: Page "Enquiry";
        ProjectRec: Record Job;
        ProjectPage: Page "Job Card";
        Act: Record AANActivity;
    begin
        case Rec."Table ID" of
            Database::Enquiry:
                begin
                    EnqRec.Get(Rec."Document No.");
                    EnqPage.DeleteAttachmentMetadataEnquiry(EnqRec."Enquiry No.", Rec."Entry No.");
                end;
            Database::Job:
                begin
                    if ProjectRec.Get(Rec."Document No.") then begin
                        // if ProjectRec."No." <> '' then
                        //     ProjectPage.UpdateAttachmentMetadataProject(ProjectRec."No.", 'Project', History."Document No.", History."File Name", History."Entry No.");
                        if ProjectRec."Enquiry No" <> '' then
                            EnqPage.DeleteAttachmentMetadataEnquiry(ProjectRec."Enquiry No", Rec."Entry No.");
                    end;
                end;
            Database::AANActivity:
                begin
                    if Act.Get(Rec."Document No.") then begin
                        if Act."Enquiry No." <> '' then
                            EnqPage.DeleteAttachmentMetadataEnquiry(Act."Enquiry No.", Rec."Entry No.");
                    end;
                end;
        end;
    end;

}