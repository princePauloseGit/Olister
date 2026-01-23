table 50245 "Sizes"
{
    Caption = 'Sizes';
    DataClassification = CustomerContent;
    LookupPageId = Sizes;
    DrillDownPageId = Sizes;

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
