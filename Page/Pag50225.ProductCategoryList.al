namespace TasksActivityModule.TasksActivityModule;

page 50225 "Product Category List"
{
    ApplicationArea = All;
    Caption = 'Product Category List';
    PageType = List;
    SourceTable = "Product Category";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Activity Code"; Rec."Product Category Code")
                {
                    ToolTip = 'Specifies the value of the Activity Code field.', Comment = '%';
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Product Type Code"; Rec."Product Type Code")
                {
                    ToolTip = 'Specifies the value of the Product type field.', Comment = '%';
                }

            }
        }
    }
}
