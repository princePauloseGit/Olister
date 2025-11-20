namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Projects.Project.Job;

enumextension 50200 "Job Status Ext" extends "Job Status"
{

    value(50201; "Customer Order")
    {
        Caption = 'Customer Order';
    }
    value(50202; "Awaits Customer")
    {
        Caption = 'Awaits Customer';
    }
    value(50203; "Shipping & Delivery")
    {
        Caption = 'Shipping & Delivery';
    }
    value(50204; "Materials & Parts")
    {
        Caption = 'Materials & Parts';
    }
    value(50205; "Product & Price Lists")
    {
        Caption = 'Product & Price Lists';
    }
    value(50206; Tenders)
    {
        Caption = 'Tenders';
    }
    value(50207; Terminology)
    {
        Caption = 'Terminology';
    }
    value(50208; Development)
    {
        Caption = 'Development';
    }
    value(50209; Research)
    {
        Caption = 'Research';
    }
}
