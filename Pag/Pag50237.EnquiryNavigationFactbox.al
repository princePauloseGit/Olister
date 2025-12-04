namespace ChilternGlobalBC.ChilternGlobalBC;
using TasksActivityModule.TasksActivityModule;
using Microsoft.Projects.Project.Job;

page 50237 "Enquiry Navigation Factbox"
{
    Caption = 'Enquiry Navigation Factbox';
    PageType = CardPart;
    SourceTable = Enquiry;

    layout
    {
        area(Content)
        {
            cuegroup(control12)
            {
                ShowCaption = false;
                Caption = 'General';

                field("All Projects"; Rec."All Projects")
                {

                    ToolTip = 'Specifies the value of the All Projects field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Caption = 'All Projects';
                    DrillDownPageID = "Job List";
                    Editable = false;
                }
                field("Live Projects"; Rec."Live Projects")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Live Projects';
                    ToolTip = 'Specifies the value of the Live Projects field.', Comment = '%';
                    Editable = false;
                    DrillDownPageID = "Job List";
                }
                field("All Activities"; Rec."All Activities")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'All Activities';
                    DrillDownPageID = "AANActivity List";
                    Editable = false;
                    ToolTip = 'Specifies the value of the All Activities field.', Comment = '%';
                }
                field("Live Activities"; Rec."Live Activities")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Live Activities';
                    DrillDownPageID = "AANActivity List";
                    Editable = false;
                    ToolTip = 'Specifies the value of the Live Activities field.', Comment = '%';
                }
                field("All Issues"; Rec."All Issues")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'All Issues';
                    DrillDownPageID = "Issues List";
                    Editable = false;
                    ToolTip = 'Specifies the value of the All Issues field.', Comment = '%';
                }
                field("Live Issues"; Rec."Live Issues")
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Live Issues';
                    DrillDownPageID = "Issues List";
                    Editable = false;
                    ToolTip = 'Specifies the value of the Live Issues field.', Comment = '%';
                }
            }
        }
    }
}
