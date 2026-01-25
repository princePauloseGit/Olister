namespace TasksActivityModule.TasksActivityModule;

using Microsoft.Projects.Project.Job;
using Microsoft.Inventory.Item;
using System.Utilities;
using ChilternGlobalBC.ChilternGlobalBC;
using Microsoft.Purchases.Vendor;

tableextension 50200 "Project EXT" extends Job
{
    fields
    {
        field(50200; "Item No"; Code[20])
        {
            Caption = 'Item No';
            DataClassification = CustomerContent;

        }
        field(50201; "Item Name"; Text[100])
        {
            Caption = 'Item Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No")));
        }
        field(50202; "Enquiry No"; Code[20])
        {
            Caption = 'Enquiry No';
            DataClassification = CustomerContent;
        }

        field(50203; "Doc Attachment List"; Blob)
        {
            Caption = 'Doc Attachment List';
            SubType = Memo;
        }
        field(50204; Quantity; Decimal)
        {
            Caption = 'Quantity';
        }
        field(50205; "Review Date"; Date)
        {
            Caption = 'Review Date';
        }
        field(50206; "Item status"; Enum "Item Status")
        {
            Caption = 'Item Status';

        }
        field(50207; "Product Type"; Code[20])
        {
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
        field(50208; "Product Category"; Code[20])
        {
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
        field(50209; "Product Group"; Code[20])
        {
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
        field(50210; "Product Range"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Product Range"."Product Range Code" where("Product Group Code" = field("Product Group"));
            ValidateTableRelation = false;
            trigger OnValidate()
            var
                ProductMgt: Codeunit "Product Hierarchy Mgt";
            begin
                ProductMgt.EnsureProductRange("Product Range", "Product Group");
            end;

        }
        field(50211; Originator; Code[20])
        {

        }
        field(50212; "Vendor No."; Code[20])
        {
            Caption = 'Supplier No.';
            TableRelation = Vendor;
        }
        field(50213; "Vendor Name"; Text[100])
        {
            Caption = 'Supplier Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Vendor.Name where("No." = field("Vendor No.")));

        }
        field(50214; "Project Image"; blob)
        {
            Caption = 'Project Image';
            DataClassification = CustomerContent;
            Subtype = Bitmap;
            trigger OnValidate()
            var
                InStr: InStream;
                FileName: Text;
            begin
                if Rec."Project Image".HasValue then begin
                    FileName := Rec."No." + '.png';
                    Rec."Project Image".CreateInStream(InStr);
                    Clear(Rec.Picture);
                    Rec.Picture.ImportStream(InStr, FileName);
                    Rec.Modify(true);
                end;
            end;
        }
        field(50215; "Picture"; MediaSet)
        {
            Caption = 'Project Image';
            DataClassification = CustomerContent;
        }
        field(50216; "Live Issues"; integer)
        {
            Caption = 'Live Issues';
            FieldClass = FlowField;
            CalcFormula = count("Issue Register" where("Project No." = field("No."), "Status" = const(Open)));
        }
        field(50217; "All Issues"; integer)
        {
            Caption = 'All Issues';
            FieldClass = FlowField;
            CalcFormula = count("Issue Register" where("Project No." = field("No.")));
        }
        field(50218; "Live Activities"; integer)
        {
            Caption = 'Live Activities';
            FieldClass = FlowField;
            CalcFormula = count(AANActivity where("Project No." = field("No."), "Table Name" = Filter('Job'), "Status" = const(Open)));
        }
        field(50219; "All Activities"; integer)
        {
            Caption = 'All Activities';
            FieldClass = FlowField;
            CalcFormula = count(AANActivity where("Table Name" = Filter('Job'), "Project No." = field("No.")));
        }
        modify(Status)
        {
            trigger OnBeforeValidate()
            var
                Issue: Record "Issue Register";
            begin
                if Status = Status::Completed then begin
                    CheckOpenActivities();
                    CheckOpenIssues();
                end;
            end;
        }

        field(50220; "Enquiry Name"; Text[100])
        {
            Caption = 'Enquiry Name';
            FieldClass = FlowField;
            CalcFormula = lookup(Enquiry.Description where("Enquiry No." = field("Enquiry No")));
        }
        field(50221; "Item Variant"; Code[20])
        {
            Caption = 'Item Variant';
            DataClassification = CustomerContent;
            TableRelation = "Item Variant".Code where("Item No." = field("Item No"));
        }
    }

    Procedure CheckOpenActivities()
    var
        Activity: Record AANActivity;
    begin
        Activity.SetFilter("Project No.", "No.");
        Activity.SetRange(Status, Activity.Status::Open);
        if Activity.FindSet() then begin
            if Confirm('Cannot Close the Project as there are Open Activities linked to it, Would you like to View the List of Open Acticities?') then
                Page.Run(Page::"AANActivity List", Activity);
            Error('Enquiry Not Closed');
        end;
    end;

    Procedure CheckOpenIssues()
    var
        Issue: Record "Issue Register";
    begin
        Issue.SetFilter("Project No.", "No.");
        Issue.SetRange(Status, Issue.Status::Open);
        if Issue.FindSet() then begin
            if Confirm('Cannot Close the Project as there are Open Issues linked to it. Would you like to View the List of Open Issues?') then
                Page.Run(Page::"Issues List", Issue);
            Error('Project Not Closed');
        end;
    end;

}
