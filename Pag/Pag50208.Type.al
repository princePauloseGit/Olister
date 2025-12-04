namespace ChilternGlobalBC.ChilternGlobalBC;

page 50208 "Type"
{
    ApplicationArea = All;
    Caption = 'Type';
    PageType = List;
    SourceTable = "Type";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Code; Rec.Code)
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
            }
        }
    }
}
