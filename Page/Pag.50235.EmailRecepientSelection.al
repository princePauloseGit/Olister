page 50235 "Email Recepient Selection"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    UsageCategory = Tasks;



    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                field(Email; Email)
                {
                    ApplicationArea = All;
                    Caption = 'Email';
                    ToolTip = 'Specifies the email address to which the email will be sent.';
                    TableRelation = "Email Recepients";
                }

            }
        }
    }

    procedure GetData(Activity: Record AANActivity)
    begin
        G_Activity := Activity;
    end;

    var
        Email: Text[80];
        G_Activity: Record AANActivity;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        Controller: Codeunit "Tasks & Activity Controller";
    begin
        if CloseAction = CloseAction::OK then
            Controller.SendEmail(G_Activity, Email);
    end;


}