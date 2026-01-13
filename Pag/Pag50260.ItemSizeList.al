page 50260 "Item Size List"
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
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the size description.';
                }
            }
        }
    }
}
