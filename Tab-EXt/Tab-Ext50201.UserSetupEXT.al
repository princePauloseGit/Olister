tableextension 50201 "User Setup Extension" extends "User Setup"
{
    fields
    {
        field(50201; "Project Sales List access"; Boolean)
        {
            Caption = 'Sales List Access in Project';
            DataClassification = CustomerContent;

        }
        field(50202; "Project Purch. List access"; Boolean)
        {
            Caption = 'Purchase List Access in Project';
            DataClassification = CustomerContent;

        }
        field(50203; "Has Activity Sharing Rights"; Boolean)
        {
            Caption = 'Has Activity Sharing Rights';
            DataClassification = CustomerContent;

        }
    }
}
