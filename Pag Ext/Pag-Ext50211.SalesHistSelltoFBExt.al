namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Sales.Document;
using System.Text;
using Microsoft.CRM.Setup;
using Microsoft.CRM.Interaction;
using Microsoft.Sales.Customer;
using Microsoft.CRM.Contact;
using Microsoft.CRM.BusinessRelation;
using TasksActivityModule.TasksActivityModule;
using Microsoft.Projects.Project.Job;

pageextension 50211 "Sales Hist. Sell-to FB Ext" extends "Sales Hist. Sell-to FactBox"
{
    layout
    {
        addbefore("No.")
        {
            field(Name; Rec.Name)
            {
                ApplicationArea = all;
                Caption = 'Customer Name';
                trigger OnDrillDown()
                var
                    myInt: Integer;
                begin
                    PAGE.Run(PAGE::"Customer Card", Rec);
                end;
            }
        }
        addfirst(Control2)
        {
            field("Live Activities"; Rec."No of Live Activities")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Live Activities';
                Editable = false;
                DrillDownPageId = "AANActivity List";
                ToolTip = 'Specifies the number of Live Activities for the customer.';
            }
            field("All Activities"; Rec."No of All Activities")
            {
                ApplicationArea = all;
                Caption = 'All Activities';
                Editable = false;
                DrillDownPageId = "AANActivity List";
                ToolTip = 'Specifies the number of All Activities for the customer.';
            }
            field("Live Issues"; Rec."No of Live Issues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Live Issues';
                Editable = false;
                DrillDownPageId = "Issues List";
                ToolTip = 'Specifies the number of Live Issues for the customer.';
            }
            field("All Issues"; Rec."No of All Issues")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'All Issues';
                Editable = false;
                DrillDownPageId = "Issues List";
                ToolTip = 'Specifies the number of All Issues for the customer.';
            }
            field("Live Enquiries"; Rec."Live Enquiries")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Live Enquiries';
                Editable = false;
                DrillDownPageId = Enquiries;
                ToolTip = 'Specifies the number of Live Enquiries for the customer.';
            }
            field("All Enquiries"; Rec."All Enquiries")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'All Enquiries';
                Editable = false;
                DrillDownPageId = Enquiries;
                ToolTip = 'Specifies the number of All Enquiries for the customer.';
            }
            field("No of Live Projects"; Rec."No of Live Projects")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Live Projects';
                Editable = false;
                DrillDownPageId = "Job List";
                ToolTip = 'Specifies the number of Live Projects for the customer.';
            }
            field("No of all Projects"; Rec."No of Projects")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'All Projects';
                Editable = false;
                DrillDownPageId = "Job List";
                ToolTip = 'Specifies the number of All Projects for the customer.';
            }
            field("All Interactions"; AllInteractions)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'All Interactions';
                Editable = false;
                ToolTip = 'Specifies the number of All Interactions for the customer.';
                DrillDown = true;
                trigger OnDrillDown()
                var
                    Rec_Interaction: Record "Interaction Log Entry";
                begin
                    Rec_Interaction.Reset();
                    Rec_Interaction.SetFilter("Contact No.", Contacts);
                    if Rec_Interaction.FindSet() then begin
                        PAGE.RunModal(PAGE::"Interaction Log Entries", Rec_Interaction);
                    end;
                end;
            }
        }
    }

    var
        AllInteractions: Integer;
        ContactCode: Code[30];
        Contacts: Text;

    trigger OnAfterGetCurrRecord()
    var
        Rec_Interaction: Record "Interaction Log Entry";
        Rec_ContactBR: Record "Contact Business Relation";
        Rec_RMSetup: Record "Marketing Setup";
        Rec_Contact: Record Contact;
        SelectionFilterMgmt: Codeunit SelectionFilterManagement;
    begin
        Clear(AllInteractions);
        Clear(Contacts);
        Clear(ContactCode);
        Clear(Rec_RMSetup);
        if Rec_RMSetup.Get() then begin
            Rec_RMSetup.TestField("Bus. Rel. Code for Customers");
            Rec_ContactBR.Reset();
            Rec_ContactBR.SetRange("Business Relation Code", Rec_RMSetup."Bus. Rel. Code for Customers");
            Rec_ContactBR.SetRange("No.", Rec."No.");
            if Rec_ContactBR.FindFirst() then
                ContactCode := Rec_ContactBR."Contact No."
            else
                ContactCode := '';

        end;

        Rec_Contact.Reset();
        Rec_Contact.Setrange("Company No.", ContactCode);
        If Rec_Contact.FindSet() then begin
            repeat
                if Contacts <> '' then begin
                    Contacts := Contacts + '|' + Rec_Contact."No.";
                end
                else begin
                    Contacts := Rec_Contact."No.";
                end;
            until Rec_Contact.Next() = 0;
        end;



        Rec_Interaction.Reset();
        Rec_Interaction.SetFilter("Contact No.", Contacts);
        if Rec_Interaction.FindSet() then
            repeat
                AllInteractions += 1;
            until Rec_Interaction.Next() = 0;

    end;
}