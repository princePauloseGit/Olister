namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Sales.Customer;
using Microsoft.Projects.Project.Job;

tableextension 50202 "Customer Ext" extends Customer
{
    fields
    {
        field(50200; "Type"; Text[20])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
            TableRelation = Type;
        }
        field(50201; Status; Enum Status)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(50202; Category; Text[50])
        {
            Caption = 'Category';
            DataClassification = CustomerContent;
        }

        field(50203; "No of Live Activities"; Integer)
        {
            CalcFormula = count(AANActivity where("Table Name" = filter('Customer'),
                                                      "Record No." = field("No."), "Status" = Filter(Open | WIP)));
            Caption = 'No. of Live Activities';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50204; "No of All Activities"; Integer)
        {
            CalcFormula = count(AANActivity where("Table Name" = filter('Customer'),
                                                      "Record No." = field("No.")));
            Caption = 'No. of All Activities';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50205; "No of Live Issues"; Integer)
        {
            CalcFormula = count("Issue Register" where("CustomerNo." = field("No."),
                                                      Status = Filter(Open)));
            Caption = 'No. of Live Issues';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50206; "No of All Issues"; Integer)
        {
            CalcFormula = count("Issue Register" where("CustomerNo." = field("No.")));
            Caption = 'No. of All Issues';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50207; "No of Projects"; Integer)
        {
            CalcFormula = count(Job where("Sell-to Customer No." = field("No.")));
            Caption = 'No. of Projects';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50208; "No of Live Projects"; Integer)
        {
            CalcFormula = count(Job where("Sell-to Customer No." = field("No."),
                                          Status = Filter(Open)));
            Caption = 'No. of Live Projects';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50209; "Live Enquiries"; Integer)
        {
            CalcFormula = count(Enquiry where("Customer No." = field("No."),
                                                             Status = filter(<> 'Closed')));
            Caption = 'Live Enquiries';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50210; "All Enquiries"; Integer)
        {
            CalcFormula = count(Enquiry where("Customer No." = field("No.")));
            Caption = 'All Enquiries';
            Editable = false;
            FieldClass = FlowField;
        }
    }
}