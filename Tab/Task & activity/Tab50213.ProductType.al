table 50213 "Product Type"
{
    Caption = 'Product Type';
    DataClassification = CustomerContent;
    LookupPageId = 50224;
    DrillDownPageId = 50224;
    fields
    {
        field(1; "Product Type Code"; Code[20])
        {
            Caption = 'Product Type Code';
            DataClassification = CustomerContent;
        }

        field(3; "Description"; Text[80])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Product Type Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Product Type Code", Description) { }
    }
}
