namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Projects.Project.Job;
using Microsoft.Projects.Project.Planning;
using TasksActivityModule.TasksActivityModule;

page 50247 "Activity Navigation Factbox"
{
    ApplicationArea = All;
    Caption = 'Activity Navigation Factbox';
    PageType = CardPart;
    SourceTable = "Job Planning Line";

    layout
    {
        area(Content)
        {
            cuegroup(General)
            {
                Caption = 'Activities';
                ShowCaption = true;
                field("All Planning Line Activities"; AllPlanningLineActivities)
                {
                    ToolTip = 'View All Activities for this Planning Line';
                    ApplicationArea = Basic, Suite;
                    Caption = 'All Activities';
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Activity: Record AANActivity;
                        ActivityList: Page "AANActivity List";
                    begin
                        Activity.SetFilter("Project No.", Rec."Job No.");
                        Activity.SetFilter("Project Task No.", Rec."Job Task No.");
                        Activity.SetFilter("Project Planning Line No", '%1', Rec."Line No.");
                        ActivityList.SetTableView(Activity);
                        ActivityList.Run();
                    end;
                }
                field("Open Planning Line Activities"; OpenPlanningLineActivities)
                {
                    ToolTip = 'View Open Activities for this Planning Line';
                    ApplicationArea = Basic, Suite;
                    Caption = 'Open Activities';
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Activity: Record AANActivity;
                        ActivityList: Page "AANActivity List";
                    begin
                        Activity.SetFilter("Project No.", Rec."Job No.");
                        Activity.SetFilter("Project Task No.", Rec."Job Task No.");
                        Activity.SetFilter("Project Planning Line No", '%1', Rec."Line No.");
                        Activity.SetFilter(Status, '%1', Activity.Status::Open);
                        ActivityList.SetTableView(Activity);
                        ActivityList.Run();
                    end;
                }
                field("Closed Planning Line Activities"; ClosedPlanningLineActivities)
                {
                    ToolTip = 'View Closed Activities for this Planning Line';
                    ApplicationArea = Basic, Suite;
                    Caption = 'Closed Activities';
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Activity: Record AANActivity;
                        ActivityList: Page "AANActivity List";
                    begin
                        Activity.SetFilter("Project No.", Rec."Job No.");
                        Activity.SetFilter("Project Task No.", Rec."Job Task No.");
                        Activity.SetFilter("Project Planning Line No", '%1', Rec."Line No.");
                        Activity.SetFilter(Status, '%1', Activity.Status::Closed);
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
        // Count all 
        Activity.Reset();
        Activity.SetFilter("Project No.", Rec."Job No.");
        Activity.SetFilter("Project Task No.", Rec."Job Task No.");
        Activity.SetFilter("Project Planning Line No", '%1', Rec."Line No.");
        AllPlanningLineActivities := Activity.Count();

        // Count open 
        Activity1.Reset();
        Activity1.SetFilter("Project No.", Rec."Job No.");
        Activity1.SetFilter("Project Task No.", Rec."Job Task No.");
        Activity1.SetFilter("Project Planning Line No", '%1', Rec."Line No.");
        Activity1.SetFilter(Status, '%1', Activity1.Status::Open);
        OpenPlanningLineActivities := Activity1.Count();

        // Count closed 
        Activity2.Reset();
        Activity2.SetFilter("Project No.", Rec."Job No.");
        Activity2.SetFilter("Project Task No.", Rec."Job Task No.");
        Activity2.SetFilter("Project Planning Line No", '%1', Rec."Line No.");
        Activity2.SetFilter(Status, '%1', Activity2.Status::Closed);
        ClosedPlanningLineActivities := Activity2.Count();
    end;

    var
        AllPlanningLineActivities: Integer;
        OpenPlanningLineActivities: Integer;
        ClosedPlanningLineActivities: Integer;
}