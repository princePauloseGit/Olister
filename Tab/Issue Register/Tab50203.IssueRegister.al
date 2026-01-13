table 50203 "Issue Register"
{
    Caption = 'Issue Register';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Issue No"; Code[30])
        {
            Caption = 'Issue No';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Tasks: Record AANActivity;
            begin
                if "Issue No" <> xRec."Issue No" then
                    if not Tasks.Get(Rec."Issue No") then begin
                        TnASetup.Get();
                        NoSeriesMgt.TestManual(TnASetup."Issue No");
                        "Issue No" := '';
                    end;
            end;
        }



        field(3; Priority; Option)
        {
            OptionMembers = Low,Medium,High;
            DataClassification = CustomerContent;
        }

        field(4; Status; Option)
        {
            OptionMembers = Open,Closed;
            Caption = 'Status';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Activity: Record AANActivity;
            begin
                if Activity.Get("Activity No.") then begin
                    if Status = Rec.Status::Closed then
                        Activity.Status := Activity.Status::Closed
                    else
                        Activity.Status := Activity.Status::Open;
                    Activity.Modify(true)
                end;

            end;

        }
        field(5; "Record ID"; Code[20])
        {
            Caption = 'Record ID';
            DataClassification = CustomerContent;
        }
        field(6; "Table Name"; Text[30])
        {
            Caption = 'Table Name';
            DataClassification = CustomerContent;
        }
        field(7; "Project No."; Code[20])
        {
            Caption = 'Project No.';
            DataClassification = CustomerContent;
        }
        field(8; "Project Name"; Text[100])
        {
            Caption = 'Project Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Job.Description where("No." = field("Project No.")));
        }
        field(9; "Enquiry No."; Code[20])
        {
            Caption = 'Enquiry No.';
            DataClassification = CustomerContent;
        }
        field(10; "Enquiry Name"; Text[100])
        {
            Caption = 'Enquiry Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Enquiry.Description where("Enquiry No." = field("Enquiry No.")));
        }

        field(13; "Project Owner"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Job."Project Manager" where("No." = field("Project No.")));
        }
        field(14; "ComplianceIssue"; Blob)
        {
            DataClassification = CustomerContent;
        }
        field(15; ComplianceIssueNotes; Blob)
        {
            DataClassification = CustomerContent;
        }
        field(16; "RootCause"; Blob)
        {
            DataClassification = CustomerContent;
        }
        field(17; RootCauseNotes; Blob)
        {
            DataClassification = CustomerContent;
        }
        field(18; "CorrectiveAction"; Blob)
        {
            DataClassification = CustomerContent;
        }
        field(19; CorrectiveActionNotes; Blob)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Activity No."; Code[20])
        {
            Caption = 'Activity No.';
            DataClassification = CustomerContent;
        }
        field(21; "Activity Name"; Text[300])
        {
            Caption = 'Activity Name';
            FieldClass = FlowField;
            CalcFormula = lookup(AANActivity."Activity Title" where("Activity No" = field("Activity No.")));
        }
        field(22; "ComplianceIssueCreatedBy"; Text[100])
        {
            TableRelation = User;
            Caption = 'Compliance Issue Created By';
            DataClassification = CustomerContent;
        }
        field(23; "ComplianceIssueDate"; DateTime)
        {
            Caption = 'Compliance Issue Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(24; "ComplianceIssueNotesCreatedBy"; Text[100])
        {
            TableRelation = User;
            Caption = 'Compliance Issue Notes Created By';
            DataClassification = CustomerContent;
        }
        field(25; "Compliance Issue Notes Date"; DateTime)
        {
            Caption = 'Compliance Issue Notes Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(26; "Root Cause Created By"; Text[100])
        {
            TableRelation = User;
            Caption = 'Root Cause Created By';
            DataClassification = CustomerContent;
        }
        field(27; "Root Cause Date"; DateTime)
        {
            Caption = 'Root Cause Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(28; "Root Cause Notes Created By"; Text[100])
        {
            TableRelation = User;
            Caption = 'Root Cause Notes Created By';
            DataClassification = CustomerContent;
        }
        field(29; "Root Cause Notes Date"; DateTime)
        {
            Caption = 'Root Cause Notes Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(30; "CorrectiveAction Created By"; Text[100])
        {
            TableRelation = User;
            Caption = 'Corrective Action Created By';
            DataClassification = CustomerContent;
        }
        field(31; "CorrectiveAction Date"; DateTime)
        {
            Caption = 'Corrective Action Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(32; "CorrectiveActionNotesCreatedBy"; Text[100])
        {
            TableRelation = User;
            Caption = 'Corrective Action Notes Created By';
            DataClassification = CustomerContent;
        }
        field(33; "CorrectiveAction Notes Date"; DateTime)
        {
            Caption = 'Corrective Action Notes Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(34; "Issue Owner"; Text[20])
        {
            DataClassification = CustomerContent;
        }
        field(35; "CustomerNo."; Code[20])
        {
            Caption = 'Customer No.';
            DataClassification = CustomerContent;
        }
        field(36; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("CustomerNo.")));
        }
        field(37; VendorNo; Code[20])
        {
            Caption = 'Vendor No.';
            DataClassification = CustomerContent;
        }
        field(38; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field(VendorNo)));
        }
    }
    keys
    {
        key(PK; "Issue No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Issue No")
        { }
    }
    trigger OnInsert()
    var
        noseriesline: Record "No. Series Line";
    begin
        // "Project Owner" := UserId;
        "Issue Owner" := UserId;

        if "Issue No" = '' then begin
            TnASetup.Get();
            TnASetup.TestField("Issue No");
            "Issue No" := NoSeriesMgt.GetNextNo(TnASetup."Issue No");

        end;
    end;


    var
        TnASetup: Record "Tasks & Activities Setup";
        NoSeriesMgt: Codeunit "No. Series";
}