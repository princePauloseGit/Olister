page 50207 "Task & Activity Card Part"
{
    PageType = CardPart;
    ApplicationArea = All;
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            cuegroup("Task & Activity")
            {
                Caption = 'Activities';
                field("Open Activities"; OpenActivities)
                {
                    Caption = 'Open Activities';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Job Queue Entries";
                    ToolTip = 'Specifies the number of Activities that are open for the current user.';
                    StyleExpr = OpenActivitiesStyle;

                    trigger OnDrillDown()
                    var
                        AATasktable: Record AANActivity;
                        TasksList: Page "AANActivity List";
                    begin
                        AATasktable.SetFilter("Assigned To UserId", UserSecurityId());
                        AATasktable.SetRange(Status, AATasktable.Status::Open);
                        TasksList.SetTableView(AATasktable);
                        TasksList.Editable(false);
                        TasksList.Run();
                    end;
                }
                field("WIP Activities"; WIPActivities)
                {
                    Caption = 'Work In Progress';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Job Queue Entries";
                    ToolTip = 'Specifies the number of Activities that are in progress for the current user.';
                    StyleExpr = WIPActivitiesStyle;

                    trigger OnDrillDown()
                    var
                        Activity: Record AANActivity;
                        ActivityList: Page "AANActivity List";
                    begin
                        Activity.SetFilter("Assigned To UserId", UserSecurityId());
                        Activity.SetRange(Status, Activity.Status::WIP);
                        ActivityList.SetTableView(Activity);
                        ActivityList.Editable(false);
                        ActivityList.Run();
                    end;
                }
                field("Closed Activities"; ClosedActivities)
                {
                    Caption = 'Closed Activities';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageID = "Job Queue Entries";
                    ToolTip = 'Specifies the number of Activities that are closed for the current user.';
                    StyleExpr = ClosedActivitiesStyle;

                    trigger OnDrillDown()
                    var
                        Activity: Record AANActivity;
                        ActivityList: Page "AANActivity List";
                    begin
                        Activity.SetFilter("Assigned To UserId", UserSecurityId());
                        Activity.SetRange(Status, Activity.Status::Closed);
                        ActivityList.SetTableView(Activity);
                        ActivityList.Editable(false);
                        ActivityList.Run();
                    end;
                }
            }
        }
    }



    var
        OpenActivities: Integer;
        OpenActivitiesStyle: Text;
        WIPActivities: Integer;
        WIPActivitiesStyle: Text;
        ClosedActivities: Integer;
        ClosedActivitiesStyle: Text;




    local procedure UpdateTasksCount()
    var
        Activity: Record AANActivity;
        user: Record User;
        username: Text;
    begin
        Activity.SetFilter("Assigned To UserId", UserSecurityId());
        Activity.SetRange(Status, Activity.Status::Open);
        OpenActivities := Activity.Count;
        Clear(Activity);
        Activity.SetRange("Assigned To UserId", UserSecurityId());
        Activity.SetRange(Status, Activity.Status::WIP);
        WIPActivities := Activity.Count;
        Clear(Activity);
        Activity.SetRange("Assigned To UserId", UserSecurityId());
        Activity.SetRange(Status, Activity.Status::Closed);
        ClosedActivities := Activity.Count;
    end;


    trigger OnAfterGetCurrRecord()
    begin
        UpdateTasksCount();
    end;
}