namespace TasksActivityModule.TasksActivityModule;

page 50224 "Product Type List"
{
    ApplicationArea = All;
    Caption = 'Product Type List';
    PageType = List;
    SourceTable = "Product Type";
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Activity Code"; Rec."Product Type Code")
                {
                    ToolTip = 'Specifies the value of the Activity Code field.', Comment = '%';
                }

                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }

            }
        }
    }
}
