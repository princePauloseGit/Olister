table 50202 "Tasks & Activities Setup"
{
    DrillDownPageID = "Task & Activity Setup";
    LookupPageID = "Task & Activity Setup";
    Caption = 'Tasks & Activities Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; PK; Integer)
        {
            AllowInCustomizations = Never;
            Caption = 'PK';
        }
        field(2; "Activity No"; Code[30])
        {
            Caption = 'Activity No';
            TableRelation = "No. Series";
        }
        field(3; "Issue No"; Code[20])
        {
            Caption = 'Issue No';
            TableRelation = "No. Series";
        }
        field(4; "Enquiry No"; Code[20])
        {
            Caption = 'Enquiry No';
            TableRelation = "No. Series";
        }
        field(5; "Staff No"; Code[20])
        {
            Caption = 'Staff No.';
            TableRelation = "No. Series";
        }
    }
    keys
    {
        key(PK; PK)
        {
            Clustered = true;
        }
    }
}
