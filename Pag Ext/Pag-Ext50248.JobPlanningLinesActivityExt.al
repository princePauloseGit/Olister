namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Projects.Project.Job;
using Microsoft.Projects.Project.Planning;

pageextension 50248 "JPLActivity Ext" extends "Job Planning Lines"
{
    layout
    {
        addlast(FactBoxes)
        {
            part(ActivityNavigationFactbox; "Activity Navigation Factbox")
            {
                ApplicationArea = All;
                Caption = 'Activities';
                SubPageLink = "Job No." = field("Job No."),
                              "Job Task No." = field("Job Task No."),
                              "Line No." = field("Line No.");
            }
        }
    }
}
