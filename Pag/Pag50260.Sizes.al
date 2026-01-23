page 50260 "Sizes"
{
    ApplicationArea = All;
    Caption = 'Sizes';
    PageType = List;
    SourceTable = "Sizes";
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
