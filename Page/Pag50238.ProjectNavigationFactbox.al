namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Projects.Project.Job;
using TasksActivityModule.TasksActivityModule;

page 50238 "Project Navigation Factbox"
{
    ApplicationArea = All;
    Caption = 'Project Navigation Factbox';
    PageType = CardPart;
    SourceTable = Job;

    layout
    {
        area(Content)
        {
            cuegroup(General)
            {
                Caption = 'General';
                ShowCaption = false;
                field("All Activities"; Rec."All Activities")
                {
                    ToolTip = 'Specifies the value of the All Activities field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Caption = 'All Activities';
                    DrillDownPageID = "AANActivity List";
                    Editable = false;
                }
                field("Live Activities"; Rec."Live Activities")
                {
                    ToolTip = 'Specifies the value of the Live Activities field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Caption = 'Live Activities';
                    DrillDownPageID = "AANActivity List";
                    Editable = false;
                }
                field("All Issues"; Rec."All Issues")
                {
                    ToolTip = 'Specifies the value of the All Issues field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Caption = 'All Issues';
                    DrillDownPageID = "Issues List";
                    Editable = false;
                }
                field("Live Issues"; Rec."Live Issues")
                {
                    ToolTip = 'Specifies the value of the Live Issues field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Caption = 'Live Issues';
                    DrillDownPageID = "Issues List";
                    Editable = false;
                }
            }
        }
    }
}
