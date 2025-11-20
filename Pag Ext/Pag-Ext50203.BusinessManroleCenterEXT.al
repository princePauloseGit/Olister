namespace TasksActivityModule.TasksActivityModule;

using Microsoft.Finance.RoleCenters;
using Microsoft.Sales.Customer;
using Microsoft.Projects.Project.Job;

pageextension 50203 "Business Man. role Center EXT" extends "Business Manager Role Center"
{
    layout
    {
        addbefore(Control16)
        {
            part("task&Activity"; "Task & Activity Card Part")
            {
                Caption = 'Activity';
                ApplicationArea = all;
            }
        }
    }
    actions
    {
        addlast(sections)
        {
            group(ChilTernGlobal)
            {
                Caption = 'Chiltern Global';
                Image = AdministrationSalesPurchases;
                ToolTip = 'Manage Chiltern Global Tasks and actions.';
                action(Enquiries)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Enquiries';
                    RunObject = Page Enquiries;
                    ToolTip = 'View or edit detailed information for the enquiries that you have created. From each enquiry card, you can open related information, such as enquiry lines and activities.';
                }

                action(Projects)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Projects';
                    RunObject = Page "Job List";
                    ToolTip = 'View or edit detailed information for the projects that you have created. From each project card, you can open related information, such as project lines and activities.';
                }

                action(Activities)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Activities';
                    RunObject = Page "AANActivity List";
                    ToolTip = 'View or edit detailed information for the activities that you have created. From each activity card, you can open related information, such as activity lines and tasks.';
                }
                action(IssueRegister)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Issue Register';
                    RunObject = Page "Issues List";
                    ToolTip = 'View or edit detailed information for the issues that you have created. From each issue card, you can open related information, such as issue lines and activities.';
                }

                action(ChilternCustomers)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                    RunObject = Page "Customer List";
                    ToolTip = 'View or edit detailed information for the customers that you have created. From each customer card, you can open related information, such as customer contacts and sales orders.';
                }
            }
        }
        addlast(creation)
        {
            action("Enquiry")
            {
                AccessByPermission = TableData Enquiry = IMD;
                ApplicationArea = Basic, Suite;
                Caption = 'Enquiry';
                Image = Opportunity;
                RunObject = Page Enquiry;
                RunPageMode = Create;
                ToolTip = 'Create New Enquiry.';
            }
        }
    }
}

