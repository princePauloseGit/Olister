namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Purchases.Payables;
using TasksActivityModule.TasksActivityModule;

pageextension 50212 "Vendor Hist. Buy-from FB Ext" extends "Vendor Hist. Buy-from FactBox"
{
    layout
    {

        addfirst(Control1)
        {
            field("Live Activities"; Rec."No of Live Activities")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Live Activities';
                DrillDownPageID = "AANActivity List";
                Editable = false;
                ToolTip = 'Specifies the number of Live Activities for the Vendor.';
            }

            field("All Activities"; Rec."No of All Activities")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'All Activities';
                DrillDownPageID = "AANActivity List";
                Editable = false;
            }
            field("No of Live Issues"; Rec."No of Live Issues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Live Issues';
                DrillDownPageID = "Issues List";
                Editable = false;
                ToolTip = 'Specifies the number of Live Issues for the Vendor.';
            }
            field("No of All Issues"; Rec."No of All Issues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'All Issues';
                DrillDownPageID = "Issues List";
                Editable = false;
                ToolTip = 'Specifies the number of All Issues for the Vendor.';
            }
        }


    }
    var
        NoOfLiveActivities: Integer;
        NoOfAllActivities: Integer;

    trigger OnAfterGetCurrRecord()
    var
        ActivityList: Page "AANActivity List";
        Activity: Record AANActivity;
    begin
        Clear(Activity);
        NoOfAllActivities := 0;
        NoOfLiveActivities := 0;
        Activity.SetFilter("Table Name", 'Vendor');
        Activity.SetFilter("Record No.", Rec."No.");
        Activity.SetFilter(Status, '%1|%2', Activity.Status::Open, Activity.Status::WIP);
        if Activity.FindSet() then
            NoOfLiveActivities := Activity.Count();

        Clear(Activity);
        Activity.SetFilter("Table Name", 'Vendor');
        Activity.SetFilter("Record No.", Rec."No.");
        if Activity.FindSet() then
            NoOfAllActivities := Activity.Count();
    end;
}
