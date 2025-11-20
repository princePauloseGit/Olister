table 50215 "Product Group"
{
    Caption = 'Product Group';
    DataClassification = CustomerContent;
    LookupPageId = 50226;
    DrillDownPageId = 50226;
    fields
    {
        field(1; "Product Group Code"; Code[20])
        {
            Caption = 'Product Group Code';
            DataClassification = CustomerContent;
        }

        field(2; "Product Category Code"; Code[20])
        {
            Caption = 'Product Category Code';
            DataClassification = CustomerContent;
            TableRelation = "Product Category";
        }

        field(3; "Description"; Text[80])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Product Group Code")
        {
            Clustered = true;
        }
        key(CategoryGroup; "Product Category Code", "Product Group Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Product Group Code", Description) { }
    }
}
