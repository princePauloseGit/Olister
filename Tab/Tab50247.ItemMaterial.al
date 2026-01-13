table 50247 "Item Material"
{
    Caption = 'Item Material';
    DataClassification = CustomerContent;
    LookupPageId = "Item Material List";
    DrillDownPageId = "Item Material List";

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
