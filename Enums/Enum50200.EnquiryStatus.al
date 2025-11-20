namespace TasksActivityModule.TasksActivityModule;

enum 50200 "Enquiry Status"
{
    Extensible = true;

    value(0; Active)
    {
        Caption = 'Active';
    }
    value(1; "Customer Order")
    {
        Caption = 'Customer Order';
    }
    value(2; "Awaits Customer")
    {
        Caption = 'Awaits Customer';
    }
    value(3; Research)
    {
        Caption = 'Research';
    }
    value(4; Closed)
    {
        Caption = 'Closed';
    }
    value(5; "Shipping & Delivery")
    {
        Caption = 'Shipping & Delivery';
    }
    value(6; "Materials & Parts")
    {
        Caption = 'Materials & Parts';
    }
    value(7; Terminology)
    {
        Caption = 'Terminology';
    }
    value(8; "Product & Price Lists")
    {
        Caption = 'Product & Price Lists';
    }
    value(9; Development)
    {
        Caption = 'Development';
    }
    value(10; Tenders)
    {
        Caption = 'Tenders';
    }
}
