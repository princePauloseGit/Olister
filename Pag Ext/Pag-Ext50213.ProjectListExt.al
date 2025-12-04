namespace ChilternGlobalBC.ChilternGlobalBC;

using TasksActivityModule.TasksActivityModule;
using Microsoft.Projects.Project.Job;

pageextension 50213 "Project List Ext" extends "Job List"
{
    layout
    {
        addfirst(Control1)
        {
            field("Starting Date"; Rec."Starting Date")
            {
                Caption = 'Start Date';
                ApplicationArea = all;
            }
            field(Quantity; Rec.Quantity)
            {
                Caption = 'Quantity';
                ApplicationArea = all;
            }
        }
        moveafter(Quantity; Description, "No.")
        addafter("No.")
        {
            field("Enquiry No"; Rec."Enquiry No")
            {
                Caption = 'Enquiry No';
                ApplicationArea = all;

            }
        }
        moveafter("Enquiry No"; "Person Responsible", Status)
        addafter(Status)
        {
            field("Ending Date"; Rec."Ending Date")
            {
                Caption = 'Due Date';
                ApplicationArea = all;

            }
        }

        addafter("Ending Date")
        {
            field("Sell-to Customer Name"; Rec."Sell-to Customer Name")
            {
                Caption = 'Customer Name';
                ApplicationArea = all;

            }
        }
        modify("Bill-to Customer No.")
        {
            Caption = 'Customer No.';
        }
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
