namespace ALProject.ALProject;
using TasksActivityModule.TasksActivityModule;

page 50245 "Activity Activity"
{
    ApplicationArea = All;
    Caption = 'Activity Activity';
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
                    ToolTip = 'View Activities Open List';
                    Caption = 'Activities Open';
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
                    ToolTip = 'View Activities for Current User';
                    Caption = 'Activities for User';
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
                    Caption = 'Activities All';
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