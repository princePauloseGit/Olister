table 50206 Enquiry
{
    Caption = 'Enquiry';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Enquiry No."; Code[20])
        {
            Caption = 'Enquiry No.';
            Editable = false;
            trigger OnValidate()
            var
                Enquiry: Record Enquiry;
            begin
                if "Enquiry No." <> xRec."Enquiry No." then
                    if not Enquiry.Get(Rec."Enquiry No.") then begin
                        TnASetup.Get();
                        NoSeriesMgt.TestManual(TnASetup."Activity No");
                        "Enquiry No." := '';
                    end;
            end;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(3; "Customer No."; Code[20])
        {
            Caption = 'Customer No.';
            TableRelation = Customer;
        }
        field(4; "Customer Name"; Text[100])
        {
            Caption = 'Customer Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Customer No.")));
        }

        field(5; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Item No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Item;
        }
        field(8; "Doc Attachment List"; Blob)
        {
            Caption = 'Doc Attachment List';
            SubType = Memo;

        }
        field(9; "Customer Address"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Address where("No." = field("Customer No.")));
        }
        field(10; "Customer Email"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."E-Mail" where("No." = field("Customer No.")));
        }
        field(11; "Customer Phone Number"; Text[30])
        {
            Caption = 'Tel';
            FieldClass = FlowField;
            CalcFormula = lookup(Customer."Phone No." where("No." = field("Customer No.")));
        }

        field(13; "Owner"; code[20])
        {
            TableRelation = "User Setup";
        }
        field(14; Originator; Code[20])
        {

        }
        field(15; Status; Enum "Enquiry Status")
        {
            trigger OnValidate()
            begin
                if Status = Status::Closed then begin
                    CheckOpenProjects();
                    CheckOpenProjects();
                    CheckOpenIssues();
                end;
            end;
        }
        field(16; "Review Date"; Date)
        {

        }
        field(17; "Live Projects"; Integer)
        {
            Caption = 'Live Projects';
            FieldClass = FlowField;
            CalcFormula = Count(Job where("Enquiry No" = field("Enquiry No."), "Status" = const(Open)));
        }
        field(18; "All Projects"; Integer)
        {
            Caption = 'All Projects';
            FieldClass = FlowField;
            CalcFormula = Count(Job where("Enquiry No" = field("Enquiry No.")));
        }
        field(19; "Live Activities"; Integer)
        {
            Caption = 'Live Activities';
            FieldClass = FlowField;
            CalcFormula = Count(AANActivity where("Enquiry No." = field("Enquiry No."), "Table Name" = filter('Enquiry'), "Status" = const(Open)));
        }
        field(20; "All Activities"; Integer)
        {
            Caption = 'All Activities';
            FieldClass = FlowField;
            CalcFormula = Count(AANActivity where("Enquiry No." = field("Enquiry No."), "Table Name" = filter('Enquiry')));
        }
        field(21; "Live Issues"; Integer)
        {
            Caption = 'Live Issues';
            FieldClass = FlowField;
            CalcFormula = Count("Issue Register" where("Enquiry No." = field("Enquiry No."), "Status" = const(Open)));
        }
        field(22; "All Issues"; Integer)
        {
            Caption = 'All Issues';
            FieldClass = FlowField;
            CalcFormula = Count("Issue Register" where("Enquiry No." = field("Enquiry No.")));
        }
    }
    keys
    {
        key(PK; "Enquiry No.")
        {
            Clustered = true;
        }
    }

    Procedure CheckOpenProjects()
    var
        Project: Record Job;
    begin
        Project.SetFilter("Enquiry No", Rec."Enquiry No.");
        Project.SetRange("Status", Project."Status"::Open);
        if Project.FindSet() then begin
            if Confirm('Cannot Close the Enquiry as there are Open Projects linked to it, Would you like to View the List of Open Projects?') then
                Page.Run(Page::"Job List", Project);
            Error('Enquiry Not Closed');
        end;
    end;

    Procedure CheckOpenActivities()
    var
        Activity: Record AANActivity;
    begin
        Activity.SetFilter("Enquiry No.", Rec."Enquiry No.");
        Activity.SetRange("Status", Activity."Status"::Open);
        if Activity.FindSet() then begin
            if Confirm('Cannot Close the Enquiry as there are Open Activities linked to it, Would you like to View the List of Open Acticities?') then
                Page.Run(Page::"AANActivity List", Activity);
            Error('Enquiry Not Closed');
        end;
    end;

    Procedure CheckOpenIssues()
    var
        Issues: Record "Issue Register";
    begin
        Issues.SetFilter("Enquiry No.", Rec."Enquiry No.");
        Issues.SetRange("Status", Issues."Status"::Open);
        if Issues.FindSet() then begin
            if Confirm('Cannot Close the Enquiry as there are Open Issues linked to it, Would you like to View the List of Open Issues?') then
                Page.Run(Page::"Issues List", Issues);
            Error('Enquiry Not Closed');
        end;
    end;

    trigger OnInsert()
    var
        noseriesline: Record "No. Series Line";
    begin
        if "Enquiry No." = '' then begin
            TnASetup.Get();
            TnASetup.TestField("Enquiry No");
            "Enquiry No." := NoSeriesMgt.GetNextNo(TnASetup."Enquiry No");
        end;
    end;


    var
        TnASetup: Record "Tasks & Activities Setup";
        NoSeriesMgt: Codeunit "No. Series";
}
