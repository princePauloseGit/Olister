namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Sales.Document;
using TasksActivityModule.TasksActivityModule;
using Microsoft.Projects.Project.Job;

pageextension 50211 "Sales Hist. Sell-to FB Ext" extends "Sales Hist. Sell-to FactBox"
{
    layout
    {
        addfirst(Control2)
        {
            field("Live Activities"; Rec."No of Live Activities")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Live Activities';
                Editable = false;
                DrillDownPageId = "AANActivity List";
                ToolTip = 'Specifies the number of Live Activities for the customer.';
            }
            field("All Activities"; Rec."No of All Activities")
            {
                ApplicationArea = all;
                Caption = 'All Activities';
                Editable = false;
                DrillDownPageId = "AANActivity List";
                ToolTip = 'Specifies the number of All Activities for the customer.';
            }
            field("Live Issues"; Rec."No of Live Issues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Live Issues';
                Editable = false;
                DrillDownPageId = "Issues List";
                ToolTip = 'Specifies the number of Live Issues for the customer.';
            }
            field("All Issues"; Rec."No of All Issues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'All Issues';
                Editable = false;
                DrillDownPageId = "Issues List";
                ToolTip = 'Specifies the number of All Issues for the customer.';
            }
            field("Live Enquiries"; Rec."Live Enquiries")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Live Enquiries';
                Editable = false;
                DrillDownPageId = "Enquiry";
                ToolTip = 'Specifies the number of Live Enquiries for the customer.';
            }
            field("All Enquiries"; Rec."All Enquiries")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'All Enquiries';
                Editable = false;
                DrillDownPageId = "Enquiry";
                ToolTip = 'Specifies the number of All Enquiries for the customer.';
            }
            field("No of Live Projects"; Rec."No of Live Projects")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Live Projects';
                Editable = false;
                DrillDownPageId = "Job List";
                ToolTip = 'Specifies the number of Live Projects for the customer.';
            }
            field("No of all Projects"; Rec."No of Projects")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'All Projects';
                Editable = false;
                DrillDownPageId = "Job List";
                ToolTip = 'Specifies the number of All Projects for the customer.';
            }
        }
    }
}