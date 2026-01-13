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

    actions
    {
        area(creation)
        {
            action("Customers")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                Image = NewSalesQuote;
                RunObject = Page "Customer Card";
                RunPageMode = Create;
                ToolTip = 'Create a new customer card.';
            }
            action("Supplier")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Supplier';
                Image = NewSalesQuote;
                RunObject = Page "Vendor Card";
                RunPageMode = Create;
                ToolTip = 'Create a new vendor card.';
            }
            action("Enquiry")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Enquiry ';
                Image = NewSalesQuote;
                RunObject = Page "Enquiry";
                RunPageMode = Create;
                ToolTip = 'Create a new enquiry card.';
            }
            action("Project")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Project';
                Image = NewSalesQuote;
                RunObject = Page "Job Card";
                RunPageMode = Create;
                ToolTip = 'Create a new project card.';
            }

        }
    }
}


