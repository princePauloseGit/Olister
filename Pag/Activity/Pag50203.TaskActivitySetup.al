namespace TasksActivityModule.TasksActivityModule;

page 50203 "Task & Activity Setup"
{
    ApplicationArea = All;
    Caption = 'Task & Activity Setup';
    PageType = Card;
    SourceTable = "Tasks & Activities Setup";
    DeleteAllowed = false;

    UsageCategory = Administration;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Activity No"; Rec."Activity No")
                {
                    ApplicationArea = all;
                    ToolTip = 'Specifies the value of the Task No field.', Comment = '%';
                }
                field("Issue No"; Rec."Issue No")
                {
                    ApplicationArea = all;
                }
                field("Enquiry No"; Rec."Enquiry No")
                {
                    ApplicationArea = all;
                }
                field("Staff No"; Rec."Staff No")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
    trigger OnOpenPage()
    var
        myInt: Integer;
    begin
        Rec.Reset();
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}
