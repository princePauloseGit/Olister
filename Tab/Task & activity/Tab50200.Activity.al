table 50200 AANActivity
{
    Caption = 'Activity';
    DataClassification = ToBeClassified;
    DrillDownPageId = 50200;
    fields
    {
        field(1; "Activity No"; Code[10])
        {
            Caption = 'Activity No';
            DataClassification = CustomerContent;
            Editable = false;
            trigger OnValidate()
            var
                Activity: Record AANActivity;
            begin
                if "Activity No" <> xRec."Activity No" then
                    if not Activity.Get(Rec."Activity No") then begin
                        TnASetup.Get();
                        NoSeriesMgt.TestManual(TnASetup."Activity No");
                        "Activity No" := '';
                    end;
            end;
        }
        field(2; "Activity Title"; text[250])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Created By"; Text[100])
        {
            TableRelation = User;
            ValidateTableRelation = false;
            Caption = 'Created By';
            DataClassification = CustomerContent;
            // trigger OnValidate()
            // var
            //     users: Record User;
            // begin
            //     if users.Get("Created By") then begin
            //         // "Accountable UserId" := Accountable;
            //         "Created By" := users."User Name"
            //     end
            //     else begin
            //         "Created By" := xRec."Created By";
            //         Message('Please Select a User from the List');
            //     end;

            // end;
        }
        field(4; "Activity type"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Activity Type" where("Created from" = field("Table Name"));
            Caption = 'Activity Type';

            trigger OnValidate()
            var
                ActivityType: Record "Activity Type";
            begin
                if ActivityType.Get("Activity type") then begin
                    "Related to" := ActivityType."Related to";
                end else begin
                    "Related to" := '';
                end;
            end;
        }
        field(5; "Description"; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description';
        }
        field(6; "Review Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Due Date"; Date)
        {
            Caption = 'Due Date';
            DataClassification = CustomerContent;
        }
        field(8; Status; Option)
        {
            OptionMembers = Open,WIP,Closed;
            OptionCaption = 'Open,Work In Progress,Closed';
            Caption = 'Status';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                user: Record User;
            begin
                if Status = Status::Closed then begin
                    user.SetFilter("User Name", UserId);
                    if user.FindFirst() then begin
                        "Completed by" := user."User Name";
                        "Completed Date" := Today();
                    end;
                end;

            end;
        }
        field(9; "Assigned To"; Text[100])
        {
            TableRelation = User;
            ValidateTableRelation = false;
            Caption = 'Assigned To';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                users: Record User;
            begin
                if users.Get("Assigned To") then begin
                    "Assigned To UserId" := "Assigned To";
                    "Assigned To" := users."User Name"
                end
                else begin
                    "Assigned To" := xRec."Assigned To";
                    Message('Please Select a User from the List');
                end;

            end;
        }
        field(10; Accountable; Text[100])
        {
            TableRelation = User;
            ValidateTableRelation = false;
            Caption = 'Accountable';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                users: Record User;
            begin
                if users.Get(Accountable) then begin
                    "Accountable UserId" := Accountable;
                    Accountable := users."User Name"
                end
                else begin
                    Accountable := xRec.Accountable;
                    Message('Please Select a User from the List');
                end;

            end;
        }
        field(11; "Tags"; text[250])
        {
            DataClassification = CustomerContent;

        }

        field(12; "Completed By"; Text[100])
        {
            Caption = 'Completed By';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(13; "Completed Date"; Date)
        {
            Caption = 'Completed Date';
            DataClassification = CustomerContent;
            Editable = false;
        }


        field(14; "Project No."; Code[20])
        {
            Caption = 'Project No.';
            DataClassification = CustomerContent;
        }
        field(15; "Project Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Job.Description where("No." = field("Project No.")));
        }
        field(16; "Project Start Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Job."Starting Date" where("No." = field("Project No.")));
        }
        field(17; "Project End Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Job."Ending Date" where("No." = field("Project No.")));
        }
        field(18; "Table Name"; Text[30])
        {
            Caption = 'Table Name';
            DataClassification = CustomerContent;
        }
        field(19; "Enquiry No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(20; "Enquiry Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Enquiry.Description where("Enquiry No." = field("Enquiry No.")));
        }
        field(21; "Enquiry Start Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Enquiry."Start Date" where("Enquiry No." = field("Enquiry No.")));
        }
        field(22; "Enquiry Due Date"; Date)
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Enquiry."Due Date" where("Enquiry No." = field("Enquiry No.")));
        }
        field(23; "Related Issue No"; Code[20])
        {
            Caption = 'Related Issue No.';
            DataClassification = CustomerContent;
            TableRelation = "Issue Register";
        }
        field(24; "Assigned To UserId"; Guid)
        {
            DataClassification = CustomerContent;
        }
        field(25; "Accountable UserId"; Guid)
        {
            DataClassification = CustomerContent;
        }
        field(26; "Sales Price List code"; Code[20])
        {
            TableRelation = "Price List Header" where("Source Type" = filter("Price Source Type"::Contact), "Price Type" = const(sale));
        }
        field(27; "Purchase Price List code"; Code[20])
        {
            TableRelation = "Price List Header" where("Source Type" = filter("Price Source Type"::Contact), "Price Type" = const(Purchase));
        }
        Field(28; "Record No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(29; Sale; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(30; Purchase; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(31; "Assigned Date"; DateTime)
        {
            Caption = 'Assigned Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(32; "Accountable Date"; DateTime)
        {
            Caption = 'Accountable Date';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(33; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(34; "Customer No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(35; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(36; "Project Task No."; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(37; "Project Planning Line No"; Integer)
        { }
        field(38; "Related to"; Text[30])
        {
            Caption = 'Related to';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Activity No")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        noseriesline: Record "No. Series Line";

    begin
        "Created By" := UserId;
        if "Activity No" = '' then begin
            TnASetup.Get();
            TnASetup.TestField("Activity No");
            "Activity No" := NoSeriesMgt.GetNextNo(TnASetup."Activity No");
        end;
    end;


    var
        TnASetup: Record "Tasks & Activities Setup";
        NoSeriesMgt: Codeunit "No. Series";
}
