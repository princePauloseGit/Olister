table 50249 "Item Color"
{
    Caption = 'Item Color';
    DataClassification = CustomerContent;
    LookupPageId = "Item Colors";
    DrillDownPageId = "Item Colors";

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
            TableRelation = Item."No.";
        }
        field(2; "Color Code"; Code[20])
        {
            Caption = 'Color Code';
            DataClassification = CustomerContent;
            TableRelation = Colors.Code;
        }
        field(3; "Color Description"; Text[100])
        {
            Caption = 'Color Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Colors.Description where(Code = field("Color Code")));
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Item No.", "Color Code")
        {
            Clustered = true;
        }
    }
}
