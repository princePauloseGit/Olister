pageextension 50245 "Item Variant Card Ext" extends "Item Variant Card"
{
    layout
    {
        addafter(Description)
        {
            group("Attribute Details")
            {
                Caption = 'Attribute Details';

                field("Size Code"; Rec."Size Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size code for this variant.';
                }
                field("Size Description"; Rec."Size Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size description.';
                }
                field("Color Code"; Rec."Color Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the color code for this variant.';
                }
                field("Color Description"; Rec."Color Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the color description.';
                }
                field("Material Code"; Rec."Material Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the material code for this variant.';
                }
                field("Material Description"; Rec."Material Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the material description.';
                }
            }
        }
    }
}
