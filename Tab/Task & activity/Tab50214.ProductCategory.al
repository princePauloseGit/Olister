table 50214 "Product Category"
{
    Caption = 'Product Category';
    DataClassification = CustomerContent;
    LookupPageId = 50225;
    DrillDownPageId = 50225;
    fields
    {
        field(1; "Product Category Code"; Code[20])
        {
            Caption = 'Product Category Code';
            DataClassification = CustomerContent;
        }

        field(2; "Product Type Code"; Code[20])
        {
            Caption = 'Product Type Code';
            DataClassification = CustomerContent;
            TableRelation = "Product Type";
        }

        field(3; "Description"; Text[80])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Product Category Code")
        {
            Clustered = true;
        }
        key(TypeCategory; "Product Type Code", "Product Category Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Product Category Code", Description) { }
    }
}
