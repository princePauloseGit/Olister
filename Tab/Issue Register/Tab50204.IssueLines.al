table 50204 "Issue Lines"
{
    Caption = 'Issue Lines';
    DataClassification = ToBeClassified;

    fields
    {

        field(1; "Issue No"; Code[30])
        {
            Caption = 'Issue No';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(3; Completed; Boolean)
        {
            Caption = 'Completed';
            DataClassification = CustomerContent;
        }
        field(4; "Line No"; Integer)
        {
            Caption = 'Activity No';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "Issue No", "Line No")
        {
            Clustered = true;
        }
    }
}
