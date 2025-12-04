namespace TasksActivityModule.TasksActivityModule;

page 50211 "Activity Type"
{
    ApplicationArea = All;
    Caption = 'Activity Type';
    PageType = ListPlus;
    SourceTable = "Activity Type";

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
            }
        }
    }
}