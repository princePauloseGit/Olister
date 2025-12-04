namespace TasksActivityModule.TasksActivityModule;

page 50206 "Issue Lines Subform"
{
    ApplicationArea = All;
    Caption = 'Activity list Subform';

    PageType = ListPart;
    SourceTable = "Issue Lines";
    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Line No"; Rec."Line No")
                {
                    Editable = false;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completed field.', Comment = '%';
                }
            }
        }
    }
}
