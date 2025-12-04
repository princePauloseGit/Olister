namespace ALProject.ALProject;
using Microsoft.Sales.Customer;

page 50243 CustActivity
{
    ApplicationArea = All;
    Caption = 'Customer Activity';
    PageType = CardPart;
    SourceTable = Customer;

    layout
    {
        area(Content)
        {
            cuegroup(Customer)
            {
                field(CustomersAll; CustomersAll)
                {

                    ToolTip = 'View All customer list';
                    Caption = 'Customers All';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Cust: Record Customer;
                        custlist: Page "Customer List";
                    begin

                        custlist.SetTableView(Cust);
                        custlist.Run();
                    end;

                }
                field(custometopen; CustomerOpen)
                {
                    ToolTip = 'View Open Customers Acitivities list';
                    Caption = 'Open Customers Activities ';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Cust: Record Customer;
                        custlist: Page "Customer List";
                    begin
                        Cust.SetRange(Status, Cust.Status::"Live / Normal");
                        custlist.SetTableView(Cust);
                        custlist.Run();
                    end;
                }

            }
        }


    }
    trigger OnAfterGetCurrRecord()
    var
        Cust: Record Customer;
        Customer: Record Customer;
    begin
        Cust.Reset();
        Cust.SetRange(Status, Cust.Status::"Live / Normal");
        CustomerOpen := Cust.Count();

        Customer.Reset();
        CustomersAll := Customer.Count();


    end;


    var
        CustomerOpen: Integer;
        CustomersAll: Integer;
}
