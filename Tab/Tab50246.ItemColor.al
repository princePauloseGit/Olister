table 50246 "Item Color"
{
    Caption = 'Item Color';
    DataClassification = CustomerContent;
    LookupPageId = "Item Color List";
    DrillDownPageId = "Item Color List";

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
