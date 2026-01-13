page 50272 "Item Material List"
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
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the material code.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the material description.';
                }
            }
        }
    }
}
