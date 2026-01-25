namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Purchases.Vendor;
using Microsoft.Projects.Project.Job;

tableextension 50203 VendorExt extends Vendor
{
    fields
    {
        field(50200; "Type"; Code[20])
        {
            Caption = 'Supplier Type';
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

                // if Rec.Status = Rec.Status::Blacklisted then begin
                //     Rec.Blocked := Rec.Blocked::Invoice;
                // end;

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
        field(50213; "Last Interaction"; DateTime)
        {
            Caption = 'Last Interaction';
            Editable = false;
        }
        field(50214; "Product Type"; Code[20])
        {
            Caption = 'Product Type';
            DataClassification = CustomerContent;
            TableRelation = "Product Type";
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                ProductMgt: Codeunit "Product Hierarchy Mgt";
            begin
                ProductMgt.EnsureProductType("Product Type");
            end;
        }
        field(50215; "Product Category"; Code[20])
        {
            Caption = 'Product Category';
            DataClassification = CustomerContent;
            TableRelation = "Product Category"."Product Category Code"
                WHERE("Product Type Code" = FIELD("Product Type"));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                ProductMgt: Codeunit "Product Hierarchy Mgt";
            begin
                ProductMgt.EnsureProductCategory("Product Category", "Product Type");
            end;
        }
        field(50216; "Product Group"; Code[20])
        {
            Caption = 'Product Group';
            DataClassification = CustomerContent;
            TableRelation = "Product Group"."Product Group Code"
                WHERE("Product Category Code" = FIELD("Product Category"));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                ProductMgt: Codeunit "Product Hierarchy Mgt";
            begin
                ProductMgt.EnsureProductGroup("Product Group", "Product Category");
            end;
        }
    }
}
