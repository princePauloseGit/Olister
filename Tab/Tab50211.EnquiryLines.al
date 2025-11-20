table 50211 "Enquiry Lines"
{
    Caption = 'Enquiry Lines';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Enquiry No"; Code[20])
        {
            Caption = 'Enquiry No';
            DataClassification = CustomerContent;
        }
        field(2; "Item No"; Code[20])
        {
            Caption = 'Item No';
            DataClassification = CustomerContent;
        }
        field(3; "Project Name"; Text[250])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Job.Description where("No." = field("Project No")));
        }
        field(4; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(5; "Project No"; Code[20])
        {
            Caption = 'Project No';
            DataClassification = CustomerContent;
        }
        field(6; "Creation Date"; Date)
        {
            Caption = 'Date';
            FieldClass = FlowField;
            CalcFormula = lookup(Job."Starting Date" where("No." = field("Project No")));
        }
        field(7; "Status"; Enum "Job Status")
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Job.Status where("No." = field("Project No")));

        }
        field(8; "Owner"; Code[50])
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Job."Project Manager" where("No." = field("Project No")));
        }
        field(9; Quantity; Decimal)
        {
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Job.Quantity where("No." = field("Project No")));
        }
        field(10; "Review Date"; Date)
        {

            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Job."Review Date" where("No." = field("Project No")));
        }

        field(11; "Line No"; Integer)
        {
            Caption = 'Line No';
        }
    }
    keys
    {
        key(PK; "Enquiry No", "Line No")
        {
            Clustered = true;
        }
    }
}
