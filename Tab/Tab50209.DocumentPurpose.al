namespace TasksActivityModule.TasksActivityModule;

table 50223 "Document Purpose"
{
    Caption = 'Document Purpose';
    DataClassification = CustomerContent;
    LookupPageId = "Document Purpose List";
    DrillDownPageId = "Document Purpose List";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}