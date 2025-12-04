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
        field(8; "Document Purpose"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Document Purpose";
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
        field(13; "Document Purpose Description"; Text[100])
        {
            Caption = 'Document Purpose Description';
            DataClassification = CustomerContent;
        }

        field(14; "Vendor No."; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
            TableRelation = Vendor;
        }
        field(15; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
            TableRelation = Customer;
        }
        field(16; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(17; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));
            Editable = false;
        }
        field(18; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
            Editable = false;
        }
        field(19; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
            Editable = false;
        }

        // Fields from AANActivity table
        field(50; "Activity Title"; Text[250])
        {
            DataClassification = CustomerContent;
        }
        field(51; "Activity Type"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Activity Type";
        }
        field(52; "Activity Created By"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(53; "Activity Status"; Option)
        {
            OptionMembers = Open,WIP,Closed;
            OptionCaption = 'Open,Work In Progress,Closed';
            DataClassification = CustomerContent;
        }
        field(54; "Activity Assigned To"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(55; "Activity Accountable"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(56; "Activity Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(57; "Activity Project No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(58; "Activity Project Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(59; "Activity Enquiry No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(60; "Activity Enquiry Name"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(61; "Activity Related Issue No"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(62; "Activity Tags"; Text[250])
        {
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