namespace ChilternGlobalBC.ChilternGlobalBC;

page 50236 "Email Recepients List"
{
    ApplicationArea = All;
    Caption = 'Email Recepients List';
    PageType = List;
    SourceTable = "Email Recepients";
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field.', Comment = '%';
                }
            }
        }
    }
}
