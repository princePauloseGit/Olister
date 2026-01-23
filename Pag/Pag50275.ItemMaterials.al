page 50275 "Item Materials"
{
    ApplicationArea = All;
    Caption = 'Item Materials';
    PageType = List;
    SourceTable = "Item Material";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Item No."; Rec."Item No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the item number.';
                }
                field("Material Code"; Rec."Material Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the material code for this item.';
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
