namespace ChilternGlobalBC.ChilternGlobalBC;
using TasksActivityModule.TasksActivityModule;

page 50209 "Staff List"
{
    ApplicationArea = All;
    Caption = 'Staff List';
    PageType = ListPart;
    SourceTable = "Staff Details";
    CardPageId = 50228;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;
    PopulateAllFields = true;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {

                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Email 1"; Rec."Email 1")
                {

                }
                field("Cont Tel 1"; Rec."Cont Tel 1")
                {

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

                Caption = 'Staff';
                action(CreateActivity)
                {
                    Caption = 'Create Staff';
                    ApplicationArea = all;
                    Image = CreateForm;
                    trigger OnAction()
                    var
                        TasksController: Codeunit "Tasks & Activity Controller";
                    begin
                        TasksController.CreateStaff(Rec."Related No.", Rec."Table Name");

                    end;
                }
            }
        }
    }
}
