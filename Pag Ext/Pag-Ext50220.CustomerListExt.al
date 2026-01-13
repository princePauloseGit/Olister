namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Sales.Customer;
using Microsoft.CRM.Interaction;
using Microsoft.CRM.Contact;

pageextension 50220 "Customer List Ext" extends "Customer List"
{
    layout
    {
        movebefore("No."; Name)

        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Search Name")
        {
            Visible = false;
        }
        modify("Balance (LCY)")
        {
            Visible = false;
        }
        modify("Balance Due (LCY)")
        {
            Visible = false;
        }
        modify("Payments (LCY)")
        {
            Visible = false;
        }
        modify("Sales (LCY)")
        {
            Visible = false;
        }
        modify("Allow Multiple Posting Groups")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
            Caption = 'Account Manager';
        }

        addafter("No.")
        {

            field(Type; Rec.Type)
            {
                ApplicationArea = All;
                Caption = 'Customer Type';
            }
            field("Date/Time Created"; Rec.SystemCreatedAt)
            {
                ApplicationArea = All;
                Caption = 'Date/Time Created';
            }
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                Caption = 'Status';
            }
            field("Last Interaction"; Rec."Last Interaction")
            {
                ApplicationArea = All;
                Caption = 'Last Interaction';
                DrillDown = true;
                trigger OnDrillDown()
                var
                    Rec_Interaction: Record "Interaction Log Entry";
                begin
                    Rec_Interaction.Reset();
                    Rec_Interaction.SetFilter("Contact No.", '%1', Rec."Primary Contact No.");
                    if Rec_Interaction.FindFirst() then
                        PAGE.Run(PAGE::"Interaction Log Entries", Rec_Interaction);
                end;
            }
            field("Account Manager"; Rec."Account Manager")
            {
                ApplicationArea = All;
                Caption = 'Account Manager';
                DrillDown = false;
                AssistEdit = false;
            }
            field(PrimaryContact; Rec.Contact)
            {
                ApplicationArea = All;
                Caption = 'Primary Contact';
                DrillDown = true;
                trigger OnDrillDown()
                var
                    Rec_Contact: Record Contact;
                begin
                    if Rec_Contact.Get(Rec."Primary Contact No.") then
                        PAGE.Run(PAGE::"Contact Card", Rec_Contact);
                end;
            }
            field("CGPhone No."; Rec."Phone No.")
            {
                ApplicationArea = All;
                Caption = 'Phone No.';
            }
            field("Mobile Phone No."; Rec."Mobile Phone No.")
            {
                ApplicationArea = All;
                Caption = 'Mobile Phone No.';
            }
            field("E-Mail"; Rec."E-Mail")
            {
                ApplicationArea = All;
                Caption = 'E-Mail';
            }

        }


        modify(Contact)
        {
            Caption = 'Primary Contact';
            Visible = false;
        }
        modify("Phone No.")
        {
            Visible = false;
        }


    }

    trigger OnAfterGetRecord()
    var
        Rec_Interaction: Record "Interaction Log Entry";
    begin

        Rec_Interaction.Reset();
        Rec_Interaction.SetRange("Contact No.", Rec."Primary Contact No.");
        if Rec_Interaction.FindLast() then
            Rec."Last Interaction" := Rec_Interaction.SystemCreatedAt
        else
            Rec."Last Interaction" := 0DT;

    end;
}
