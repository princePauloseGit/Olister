namespace TasksActivityModule.TasksActivityModule;
using Microsoft.Projects.Project.Job;

page 50212 "Activity List Part FactBox"
{
    ApplicationArea = All;
    Caption = 'Related Activity';
    PageType = ListPart;
    SourceTable = AANActivity;
    CardPageId = 50201;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    PopulateAllFields = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(SystemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'Date';
                }
                field("Activity Title"; Rec."Activity Title")
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Activity type"; Rec."Activity type")
                {
                    Caption = 'Activity Type';
                    ToolTip = 'Specifies the value of the Activity type field.', Comment = '%';
                }
            }
        }

    }
    actions
    {
        area(Processing)
        {
            group("Activity")
            {

                Caption = 'Activity';
                action(CreateActivity)
                {
                    Caption = 'Create an Activity';
                    ApplicationArea = all;
                    Image = CreateForm;
                    trigger OnAction()
                    var
                        TasksController: Codeunit "Tasks & Activity Controller";
                        Project: Record Job;
                        Enquiry: Record Enquiry;
                        EnquiryNo: Code[20];
                    begin
                        case Rec."Table Name" of
                            'Job':
                                begin
                                    if Project.get(Rec."Project No.") then begin
                                        EnquiryNo := Project."Enquiry No";
                                        TasksController.CreateActivityForProject(Rec."Project No.", Rec."Table Name", EnquiryNo);
                                    end
                                end;
                            'Enquiry':
                                begin
                                    if Enquiry.Get(Rec."Record No.") then begin
                                        TasksController.CreateActivity(Rec."Record No.", Rec."Table Name");
                                    end;
                                end;
                            'Customer':
                                begin
                                    TasksController.CreateActivity(Rec."Record No.", Rec."Table Name");
                                end;
                            'Vendor':
                                begin
                                    TasksController.CreateActivity(Rec."Record No.", Rec."Table Name");
                                end;
                        end;


                    end;
                }
            }
        }
    }
}

