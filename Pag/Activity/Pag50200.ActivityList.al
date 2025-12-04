namespace TasksActivityModule.TasksActivityModule;
using System.Security.AccessControl;

page 50200 "AANActivity List"
{
    ApplicationArea = All;
    Caption = 'Activity List';
    PageType = List;
    SourceTable = AANActivity;
    UsageCategory = Lists;
    CardPageId = "Activity Card";
    ModifyAllowed = false;
    DeleteAllowed = false;
    InsertAllowed = false;
    Editable = false;

    layout
    {
        area(Content)
        {


            repeater(General)
            {
                Editable = false;
                field(SystemCreatedAt; Rec.SystemCreatedAt.Date)
                {
                    Caption = 'Start Date';
                }
                field("Activity No"; Rec."Activity No")
                {
                    ToolTip = 'Specifies the value of the Activity No field.', Comment = '%';
                }
                field("Activity Title"; Rec."Activity Title")
                {
                    ToolTip = 'Specifies the value of the Activity No field.', Comment = '%';
                }
                field("Related Issue No"; Rec."Related Issue No")
                {
                    ToolTip = 'Specifies the value of the Related Issue No field.', Comment = '%';
                    ;
                }
                field("Assigned To"; Rec."Assigned To")
                {
                    ToolTip = 'Specifies the value of the Assigned to field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("completed Date"; Rec."completed Date")
                {
                    ToolTip = 'Specifies the value of the completed Date field.', Comment = '%';
                }
                field("Completed by"; Rec."Completed by")
                {
                    ToolTip = 'Specifies the value of the Completed by field.', Comment = '%';
                }
                field("Enquiry No."; Rec."Enquiry No.")
                { }
                field("Project No."; Rec."Project No.")
                {
                    ToolTip = 'Specifies the value of the Record ID field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        Cod: Codeunit "Tasks & Activity Controller";
                    begin

                        if rec."Table Name" = 'Job' then
                            Cod.OpenProjectRecord(Rec."Project No.");
                    end;
                }
                field(Accountable; Rec.Accountable)
                {
                    ToolTip = 'Specifies the value of the Accountable field.', Comment = '%';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.', Comment = '%';
                }
                field("Table Name"; Rec."Table Name")
                {
                    ToolTip = 'Specifies the value of the Table Name field.', Comment = '%';
                }
            }
        }
    }

    actions
    {
        area(Creation)
        {
            action(New)
            {
                Visible = false;
            }
        }
        area(Processing)
        {
            action(Edit)
            {
                Visible = false;
            }
            action(Delete)
            {
                Visible = false;
            }
        }
    }
}
