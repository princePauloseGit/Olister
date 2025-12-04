namespace ALProject.ALProject;
using TasksActivityModule.TasksActivityModule;

page 50245 "Activity Activity"
{
    ApplicationArea = All;
    Caption = 'Activities';
    PageType = CardPart;
    SourceTable = AANActivity;

    layout
    {
        area(Content)
        {
            cuegroup(Activities)
            {
                field(ActivitiesOpen; ActivitiesOpen)
                {
                    ToolTip = 'View All Open Activites List';
                    Caption = 'All Open Activities';
                    trigger OnDrillDown()
                    var
                        Activity: Record AANActivity;
                        ActivityList: Page "AANActivity List";
                    begin
                        Activity.SetFilter(Status, '<>%1', Activity.Status::Closed);
                        ActivityList.SetTableView(Activity);
                        ActivityList.Run();
                    end;
                }

                field(ActivitiesForUser; ActivitiesForUser)
                {
                    ToolTip = 'View All Activities assigned to you';
                    Caption = 'Activities associated with you';
                    trigger OnDrillDown()
                    var
                        Activity: Record AANActivity;
                        ActivityList: Page "AANActivity List";
                    begin
                        Activity.SetFilter("Assigned To", UserId);
                        ActivityList.SetTableView(Activity);
                        ActivityList.Run();
                    end;
                }

                field(ActivitiesAll; ActivitiesAll)
                {
                    ToolTip = 'View All Activities List';
                    Caption = 'All Activities';
                    trigger OnDrillDown()
                    var
                        Activity: Record AANActivity;
                        ActivityList: Page "AANActivity List";
                    begin
                        ActivityList.SetTableView(Activity);
                        ActivityList.Run();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        Activity: Record AANActivity;
        Activity1: Record AANActivity;
        Activity2: Record AANActivity;
    begin
        Activity.Reset();
        Activity.SetFilter(Status, '<>%1', Activity.Status::Closed);
        ActivitiesOpen := Activity.Count();

        Activity1.Reset();
        Activity1.SetFilter("Assigned To", UserId);
        ActivitiesForUser := Activity1.Count();

        Activity2.Reset();
        ActivitiesAll := Activity2.Count();
    end;

    var
        ActivitiesOpen: Integer;
        ActivitiesForUser: Integer;
        ActivitiesAll: Integer;
}