table 50216 "Product Range"
{
    Caption = 'Product Range';
    DataClassification = CustomerContent;
    LookupPageId = 50227;
    DrillDownPageId = 50227;
    fields
    {
        field(1; "Product Range Code"; Code[20])
        {
            Caption = 'Product Range Code';
            DataClassification = CustomerContent;
        }

        field(2; "Product Group Code"; Code[20])
        {
            Caption = 'Product Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Product Group";
        }

        field(3; "Description"; Text[80])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Product Range Code")
        {
            Clustered = true;
        }
        key(GroupRange; "Product Group Code", "Product Range Code")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Product Range Code", Description) { }
    }
}
