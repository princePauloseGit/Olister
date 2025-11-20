namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Purchases.Vendor;
using Microsoft.Projects.Project.Job;

tableextension 50203 VendorExt extends Vendor
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

        field(50203; "Job Title"; Text[100])
        {
            Caption = 'Job Title';
            DataClassification = CustomerContent;
        }
        field(50204; "No of Live Activities"; Integer)
        {
            CalcFormula = count(AANActivity where("Table Name" = filter('Vendor'),
                                                      "Record No." = field("No."), "Status" = Filter(Open | WIP)));
            Caption = 'No. of Live Activities';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50205; "No of All Activities"; Integer)
        {
            CalcFormula = count(AANActivity where("Table Name" = filter('Vendor'),
                                                      "Record No." = field("No.")));
            Caption = 'No. of All Activities';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50206; "No of Live Issues"; Integer)
        {
            CalcFormula = count("Issue Register" where(VendorNo = field("No."),
                                                      Status = Filter(Open)));
            Caption = 'No. of Live Issues';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50207; "No of All Issues"; Integer)
        {
            CalcFormula = count("Issue Register" where(VendorNo = field("No.")));
            Caption = 'No. of All Issues';
            Editable = false;
            FieldClass = FlowField;
        }



    }
}
