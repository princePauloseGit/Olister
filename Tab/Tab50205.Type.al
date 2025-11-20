table 50205 "Type"
{
    Caption = 'Type';
    DataClassification = CustomerContent;
    LookupPageId = 50208;
    DrillDownPageId = 50208;
    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Code, Name) { }
    }
}
