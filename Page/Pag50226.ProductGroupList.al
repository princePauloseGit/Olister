namespace TasksActivityModule.TasksActivityModule;

page 50226 "Product Group List"
{
    ApplicationArea = All;
    Caption = 'Product Group List';
    PageType = List;
    SourceTable = "Product Group";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ToolTip = 'Specifies the value of the Product Group Code field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Product Category Code"; Rec."Product Category Code")
                {
                    ToolTip = 'Specifies the value of the Product Category Code field.', Comment = '%';
                }
            }
        }
    }
}
