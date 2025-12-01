namespace TasksActivityModule.TasksActivityModule;

page 50202 "Activity Type List"
{
    ApplicationArea = All;
    Caption = 'Activity Type List';
    PageType = List;
    SourceTable = "Activity Type";
    UsageCategory = Lists;    
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Activity Code"; Rec."Activity Code")
                {
                    ToolTip = 'Specifies the value of the Activity Code field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Default Next Step"; Rec."Default Next Step")
                {
                    ToolTip = 'Specifies the value of the Default Next Step field.', Comment = '%';
                }
                field("Created from"; Rec."Created from")
                {
                    ToolTip = 'Specifies the value of the Created from field.', Comment = '%';
                }
                field("Related to"; Rec."Related to")
                {
                    ToolTip = 'Specifies the value of the Related to field.', Comment = '%';
                }
            }
        }
    }
}
