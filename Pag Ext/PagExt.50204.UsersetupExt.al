pageextension 50204 "User Setup Extension" extends "User Setup"
{
    layout
    {
        addafter("Allow Deferral Posting From")
        {
            field("Project Purch. List access"; Rec."Project Purch. List access")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specify if you want user to access the Purchase List in the Project.';
            }
            field("Project Sales List access"; Rec."Project Sales List access")
            {
                ApplicationArea = Basic, Suite;
                ToolTip = 'Specify if you want user to access the Sales List in the Project.';
            }
        }

    }

    actions
    {

    }
}
