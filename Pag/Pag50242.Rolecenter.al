page 50242 "CG Role center"
{
    ApplicationArea = All;
    Caption = 'Chiltern Global Role center';
    PageType = RoleCenter;

    layout
    {
        area(Rolecenter)
        {
            group(Main)
            {
                part(CustomerAcitivity; CustActivity)
                {
                    ApplicationArea = All;
                }
                part(VendorAcitivity; VendorActivity)
                {
                    ApplicationArea = All;
                }

                part(Enquiries; "Enquiry Acitivity")
                {
                    ApplicationArea = All;
                }
                part(Projects; "Project Acitivity")
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
}


