page 50242 "Role center Test "
{
    ApplicationArea = All;
    Caption = 'Role center Test';
    PageType = RoleCenter;

    layout
    {
        area(Rolecenter)
        {

            part(CustomerAcitivity; CustActivity)
            {
                ApplicationArea = All;
            }
            part(Enquries; "Enquiry Acitivity")
            {
                ApplicationArea = All;
            }
            part(VendorAcitivity; VendorActivity)
            {
                ApplicationArea = All;
            }
            part(Project; "Project Acitivity")
            {
                ApplicationArea = All;
            }
            part(ActivityActivity; "Activity Activity")
            {
                ApplicationArea = All;
            }
            part(IssueRegisterActivity; "Issue Register Activity")
            {
                ApplicationArea = All;
            }
        }
    }
}
