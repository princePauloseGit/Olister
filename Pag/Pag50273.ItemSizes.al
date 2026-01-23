page 50273 "Item Sizes"
{
    ApplicationArea = All;
    Caption = 'Item Sizes';
    PageType = List;
    SourceTable = "Item Size";
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
                field("Size Code"; Rec."Size Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size code for this item.';
                }
                field("Size Description"; Rec."Size Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size description.';
                }
            }
        }
    }
}
