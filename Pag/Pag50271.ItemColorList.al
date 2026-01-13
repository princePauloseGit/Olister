page 50271 "Item Color List"
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
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the color code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the color description.';
                }
            }
        }
    }
}
