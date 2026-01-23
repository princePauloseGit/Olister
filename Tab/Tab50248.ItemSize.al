table 50248 "Item Size"
{
    Caption = 'Item Size';
    DataClassification = CustomerContent;
    LookupPageId = "Item Sizes";
    DrillDownPageId = "Item Sizes";

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item."No.";
        }
        field(2; "Size Code"; Code[20])
        {
            Caption = 'Size Code';
            DataClassification = CustomerContent;
            TableRelation = Sizes.Code;
        }
        field(3; "Size Description"; Text[100])
        {
            Caption = 'Size Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Sizes.Description where(Code = field("Size Code")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Item No.", "Size Code")
        {
            Clustered = true;
        }
    }
}
