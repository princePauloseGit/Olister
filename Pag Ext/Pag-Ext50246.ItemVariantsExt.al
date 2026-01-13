pageextension 50246 "Item Variants Ext" extends "Item Variants"
{
    layout
    {
        addafter(Description)
        {
            field("Size Code"; Rec."Size Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the size code for this variant.';
            }
            field("Color Code"; Rec."Color Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the color code for this variant.';
            }
            field("Material Code"; Rec."Material Code")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the material code for this variant.';
            }
        }
    }
}
