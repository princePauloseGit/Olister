page 50274 "Item Colors"
{
    ApplicationArea = All;
    Caption = 'Item Colors';
    PageType = List;
    SourceTable = "Item Color";
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
                field("Color Code"; Rec."Color Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the color code for this item.';
                }
                field("Color Description"; Rec."Color Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the color description.';
                }
            }
        }
    }
}
