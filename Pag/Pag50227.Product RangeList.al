namespace TasksActivityModule.TasksActivityModule;

page 50227 "Product Range List"
{
    ApplicationArea = All;
    Caption = 'Product Range List';
    PageType = List;
    SourceTable = "Product Range";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Product Range Code"; Rec."Product Range Code")
                {
                    ToolTip = 'Specifies the value of the Product Range Code field.', Comment = '%';
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Product Group Code"; Rec."Product Group Code")
                {
                    ToolTip = 'Specifies the value of the Product Group Code field.', Comment = '%';
                }
            }
        }
    }
}
