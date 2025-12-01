table 50201 "Activity Type"
{
    Caption = 'Activity Type';
    DataClassification = ToBeClassified;
    LookupPageId = 50202;
    DrillDownPageId = 50202;
    fields
    {
        field(1; "Activity Code"; Code[20])
        {
            Caption = 'Activity Code';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[20])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
        field(3; Description; Text[80])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(4; "Default Next Step"; Enum "Activity Next Step")
        {
            Caption = 'Default Next Step';
            DataClassification = CustomerContent;
        }
        field(5; "Created from"; Text[30])
        {
            Caption = 'Created from';
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object Name" where("Object Type" = const(Table));
            ValidateTableRelation = false;
        }
        field(6; "Related to"; Text[30])
        {
            Caption = 'Related to';
            DataClassification = CustomerContent;
            TableRelation = AllObjWithCaption."Object Name" where("Object Type" = const(Table));
            ValidateTableRelation = false;
        }
    }

    keys
    {
        key(PK; "Activity Code")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Activity Code", Description, "Default Next Step") { }
    }
}
