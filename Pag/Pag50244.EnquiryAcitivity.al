namespace ALProject.ALProject;
using TasksActivityModule.TasksActivityModule;

page 50244 "Enquiry Acitivity"
{
    ApplicationArea = All;
    Caption = 'Enquiry Activity ';
    PageType = CardPart;
    SourceTable = "Enquiry Lines";

    layout
    {
        area(Content)
        {
            cuegroup(Enquiries)
            {
                field(EnquiriesOpen; EnquiriesOpen)
                {

                    ToolTip = 'View Open Enquiry List associated with you';
                    Caption = 'Your Open Enquiries';
                    trigger OnDrillDown()
                    var
                        Enquiries: Record Enquiry;
                        EnquriesList: Page Enquiries;
                    begin
                        Enquiries.SetFilter(Owner, UserId);
                        Enquiries.SetFilter(Status, '<>%1', Enquiries.Status::Closed);
                        EnquriesList.SetTableView(Enquiries);
                        EnquriesList.Run();
                    end;
                }

                field(EnquiriesAllforUser; EnquiriesAllforUser)
                {

                    ToolTip = 'View Enquire All List associated with you';
                    Caption = 'All your Enquiries';
                    trigger OnDrillDown()
                    var
                        Enquiries: Record Enquiry;
                        EnquriesList: Page Enquiries;
                    begin
                        Enquiries.SetFilter(Owner, UserId);
                        EnquriesList.SetTableView(Enquiries);
                        EnquriesList.Run();
                    end;
                }

                field(EnquiriesAll; EnquiriesAll)
                {

                    ToolTip = 'View Enquire All List';
                    Caption = 'All Enquiries';
                    trigger OnDrillDown()
                    var
                        Enquiries: Record Enquiry;
                        EnquriesList: Page Enquiries;
                    begin
                        EnquriesList.SetTableView(Enquiries);
                        EnquriesList.Run();
                    end;
                }


            }
        }
    }


    trigger OnAfterGetCurrRecord()
    var

        Enquiries: Record Enquiry;
        Enquiries1: Record Enquiry;
        Enquiries2: Record Enquiry;

    begin
        Enquiries.Reset();
        Enquiries.SetFilter(Status, '<>%1', Enquiries.Status::Closed);
        Enquiries.SetRange(Owner, UserId);
        EnquiriesOpen := Enquiries.Count();

        Enquiries1.Reset();
        Enquiries1.SetRange(Owner, UserId);
        EnquiriesAllforUser := Enquiries1.Count();

        Enquiries2.Reset();
        EnquiriesAll := Enquiries2.Count();
    end;

    var
        EnquiriesOpen: Integer;
        EnquiriesAllforUser: Integer;

        EnquiriesAll: Integer;
}
