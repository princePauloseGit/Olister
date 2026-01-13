namespace ChilternGlobalBC.ChilternGlobalBC;
using TasksActivityModule.TasksActivityModule;
using Microsoft.CRM.Task;

page 50231 "Project Vendor Subform"
{
    ApplicationArea = All;
    Caption = 'Project Suppliers Subform';
    PageType = ListPart;
    SourceTable = "Project vendors";
    Editable = true;
    // AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ToolTip = 'Specifies the value of the Vendor Name field.', Comment = '%';
                    Caption = 'Supplier Name';

                }
                field("Vendor No"; Rec."Vendor No")
                {
                    ToolTip = 'Specifies the value of the Vendor No field.', Comment = '%';
                    Caption = 'Supplier No';
                }
                field("Activity No"; Rec."Activities")
                {
                    ToolTip = 'Specifies the value of the Activity No field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        Activity: Record AANActivity;
                    begin
                        Activity.SetRange("Project No.", Rec."Project No");
                        Activity.SetRange("Vendor No.", Rec."Vendor No");

                        if Activity.FindSet() then
                            PAGE.Run(PAGE::"AANActivity List", Activity);
                    end;

                }
            }
        }
    }
    // trigger OnAfterGetCurrRecord()
    // var
    //     Activity: Record AANActivity;
    // begin
    //     Activity.SetRange("Project No.", Rec."Project No");
    //     Activity.SetRange("Vendor No.", Rec."Vendor No");
    //     Rec.
    // end;
}
