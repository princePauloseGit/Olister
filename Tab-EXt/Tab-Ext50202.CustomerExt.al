namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Sales.Customer;
using Microsoft.CRM.Contact;
using Microsoft.CRM.Team;
using Microsoft.Foundation.Address;
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

            trigger OnValidate()
            begin
                if Rec.Status = Rec.Status::Inactive then begin
                    Rec.Blocked := Rec.Blocked::All;
                end;

                if Rec.Status = Rec.Status::Blacklisted then begin
                    Rec.Blocked := Rec.Blocked::Invoice;
                end;

                if Rec.Status = Rec.Status::"Live / Normal" then begin
                    Rec.Blocked := Rec.Blocked::" ";
                end;

                if Rec.Status = Rec.Status::Prime then begin
                    Rec.Blocked := Rec.Blocked::" ";
                end;
            end;
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
        field(50211; "CGE-Mail"; text[250])
        {
            Caption = 'E-Mail';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact."E-Mail" where("No." = FIELD("Primary Contact No.")));
        }
        field(50212; "CGMobilePhone"; text[250])
        {
            Caption = 'Mobile Phone';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(Contact."Mobile Phone No." where("No." = FIELD("Primary Contact No.")));
        }
        field(50213; "Last Interaction"; DateTime)
        {
            Caption = 'Last Interaction';
            Editable = false;
        }
        field(50214; "Account Manager"; Text[100])
        {
            Caption = 'Account Manager';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Salesperson/Purchaser".Name where("Code" = FIELD("Salesperson Code")));
        }
        field(50215; "Company Reg. No."; Text[50])
        {
            Caption = 'Company Reg. No.';
            DataClassification = CustomerContent;
        }
        field(50216; "NCAGE Code"; Text[20])
        {
            Caption = 'NCAGE Code';
            DataClassification = CustomerContent;
        }
        field(50217; "Duns No."; Text[20])
        {
            Caption = 'Duns No.';
            DataClassification = CustomerContent;
        }
        field(50218; "Country/Region"; Text[100])
        {
            Caption = 'Country/Region';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Country/Region".Name where("Code" = FIELD("Country/Region Code")));
        }









    }
}