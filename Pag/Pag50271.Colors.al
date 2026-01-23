page 50271 "Colors"
{
    ApplicationArea = All;
    Caption = 'Colors';
    PageType = List;
    SourceTable = "Colors";
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
