namespace ChilternGlobalBC.ChilternGlobalBC;

using TasksActivityModule.TasksActivityModule;
using Microsoft.Projects.Project.Job;

pageextension 50213 "Project List Ext" extends "Job List"
{
    layout
    {
        movebefore("No."; Description)
        addafter(Control1905650007)
        {
            part("Project Navigation Factbox"; "Project Navigation Factbox")
            {
                ApplicationArea = all;
                Caption = 'Project Navigation';
                SubPageLink = "No." = field("No.");
            }
        }
    }
}
