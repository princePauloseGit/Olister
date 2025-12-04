namespace ALProject.ALProject;

using Microsoft.Projects.Project.Job;

page 50241 "Project Acitivity"
{
    ApplicationArea = All;
    Caption = 'Project Activity';
    PageType = CardPart;
    SourceTable = "Job";


    layout
    {
        area(Content)
        {
            cuegroup(Project)
            {
                field(ProjectOpen; ProjectOpen)
                {

                    ToolTip = 'View Open Project List associated with you';
                    Caption = 'All your Open Projects';
                    trigger OnDrillDown()
                    var
                        job: Record Job;
                        joblist: Page "Job List";
                    begin
                        job.SetRange("Project Manager", UserId);
                        job.SetFilter(Status, '<>%1', job.Status::Completed);
                        joblist.SetTableView(job);
                        joblist.Run();
                    end;
                }

                field(ProjectAllUser; ProjectAllUser)
                {

                    ToolTip = 'View Project All List associated with you';
                    Caption = 'All your Projects';
                    trigger OnDrillDown()
                    var
                        job: Record Job;
                        joblist: Page "Job List";
                    begin
                        job.SetRange("Project Manager", UserId);
                        joblist.SetTableView(job);
                        joblist.Run();
                    end;

                }

                field(ProjectAll; ProjectAll)
                {

                    ToolTip = 'View All Projects List';
                    Caption = 'All Projects';
                    trigger OnDrillDown()
                    var
                        job: Record Job;
                        joblist: Page "Job List";
                    begin

                        joblist.SetTableView(job);
                        joblist.Run();
                    end;
                }


            }
        }
    }


    trigger OnAfterGetCurrRecord()
    var

        job: Record Job;
        job1: Record Job;
        job2: Record Job;

    begin
        job.Reset();
        job.SetRange("Project Manager", UserId);
        job.SetFilter(Status, '<>%1', job.Status::Completed);
        ProjectOpen := job.Count();

        job1.Reset();
        job1.SetFilter("Project Manager", UserId);
        ProjectAllUser := job1.Count();

        job2.Reset();
        ProjectAll := job2.Count();
    end;

    var
        ProjectOpen: Integer;
        ProjectAllUser: Integer;

        ProjectAll: Integer;
}

