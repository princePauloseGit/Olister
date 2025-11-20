namespace TasksActivityModule.TasksActivityModule;
using System.Security.AccessControl;

page 50200 "AANActivity List"
{
    ApplicationArea = All;
    Caption = 'Activity List';
    PageType = List;
    SourceTable = AANActivity;
    UsageCategory = Lists;
    CardPageId = 50201;
    ModifyAllowed = false;
    Editable = false;
    layout
    {
        area(Content)
        {


            repeater(General)
            {
                field("Activity No"; Rec."Activity No")
                {
                    ToolTip = 'Specifies the value of the Activity No field.', Comment = '%';
                }
                field("Activity Title"; Rec."Activity Title")
                {
                    ToolTip = 'Specifies the value of the Activity No field.', Comment = '%';
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
                field("Assigned To"; Rec."Assigned To")
                {
                    ToolTip = 'Specifies the value of the Assigned to field.', Comment = '%';
                }
                field(Accountable; Rec.Accountable)
                {
                    ToolTip = 'Specifies the value of the Accountable field.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                }
                field("Due Date"; Rec."Due Date")
                {
                    ToolTip = 'Specifies the value of the Due Date field.', Comment = '%';
                }




                field("Completed by"; Rec."Completed by")
                {
                    ToolTip = 'Specifies the value of the Completed by field.', Comment = '%';
                }
                field("Related Issue No"; Rec."Related Issue No")
                {
                    ToolTip = 'Specifies the value of the Related Issue No field.', Comment = '%';
                    ;
                }

                field("Table Name"; Rec."Table Name")
                {
                    ToolTip = 'Specifies the value of the Table Name field.', Comment = '%';
                }



                field("completed Date"; Rec."completed Date")
                {
                    ToolTip = 'Specifies the value of the completed Date field.', Comment = '%';
                }
            }
        }
    }
}
