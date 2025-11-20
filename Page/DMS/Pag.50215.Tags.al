page 50215 Tag
{
    ApplicationArea = All;
    Caption = 'Document Tag';
    PageType = List;
    SourceTable = TagMaster;
    UsageCategory = Lists;
    InsertAllowed = true;
    ModifyAllowed = true;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    Caption = 'Entry No';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the EntryNo field.', Comment = '%';
                }
                field(Tag; Rec.Tag)
                {
                    Caption = 'Document Tag';
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Tag field.', Comment = '%';
                }
            }
        }
    }
}