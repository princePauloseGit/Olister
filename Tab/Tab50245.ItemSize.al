table 50245 "Item Size"
{
    Caption = 'Item Size';
    DataClassification = CustomerContent;
    LookupPageId = "Item Size List";
    DrillDownPageId = "Item Size List";

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
