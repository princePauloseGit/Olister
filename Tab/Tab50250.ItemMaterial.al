table 50250 "Item Material"
{
    Caption = 'Item Material';
    DataClassification = CustomerContent;
    LookupPageId = "Item Materials";
    DrillDownPageId = "Item Materials";

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item."No.";
        }
        field(2; "Material Code"; Code[20])
        {
            Caption = 'Material Code';
            DataClassification = CustomerContent;
            TableRelation = Materials.Code;
        }
        field(3; "Material Description"; Text[100])
        {
            Caption = 'Material Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Materials.Description where(Code = field("Material Code")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Item No.", "Material Code")
        {
            Clustered = true;
        }
    }
}
