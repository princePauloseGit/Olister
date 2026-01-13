tableextension 50245 "Item Variant Ext" extends "Item Variant"
{
    fields
    {
        field(50245; "Size Code"; Code[20])
        {
            Caption = 'Size Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Size".Code;
        }
        field(50246; "Color Code"; Code[20])
        {
            Caption = 'Color Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Color".Code;
        }
        field(50247; "Material Code"; Code[20])
        {
            Caption = 'Material Code';
            DataClassification = CustomerContent;
            TableRelation = "Item Material".Code;
        }
        field(50248; "Size Description"; Text[100])
        {
            Caption = 'Size Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Size".Description where(Code = field("Size Code")));
            Editable = false;
        }
        field(50249; "Color Description"; Text[100])
        {
            Caption = 'Color Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Color".Description where(Code = field("Color Code")));
            Editable = false;
        }
        field(50250; "Material Description"; Text[100])
        {
            Caption = 'Material Description';
            FieldClass = FlowField;
            CalcFormula = lookup("Item Material".Description where(Code = field("Material Code")));
            Editable = false;
        }
    }
}
