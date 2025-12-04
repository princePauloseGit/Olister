namespace ChilternGlobalBC.ChilternGlobalBC;
using System.Security.AccessControl;

page 50230 "Item Version List"
{
    ApplicationArea = All;
    Caption = 'Item Version List';
    PageType = List;
    SourceTable = "Item Version Master";
    UsageCategory = Lists;
    // Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.', Comment = '%';
                }
                field("Previous Version"; Rec."Previous Version")
                {
                    ToolTip = 'Specifies the value of the Previous Version field.', Comment = '%';
                }
                field("Created By"; CreatedBy)
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Created At"; Rec.SystemCreatedAt)
                {
                    ToolTip = 'Specifies the value of the Created At field.', Comment = '%';
                }
            }
        }
    }
    Var
        CreatedBy: Text[50];

    trigger OnAfterGetCurrRecord()
    var
        User: Record User;
    begin
        if User.Get(Rec.SystemCreatedBy) then
            CreatedBy := User."Full Name"
        else
            CreatedBy := '';

    end;


}
