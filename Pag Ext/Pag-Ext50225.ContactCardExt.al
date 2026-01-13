namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.CRM.Contact;

pageextension 50225 ContactCardExt extends "Contact Card"
{
    DataCaptionExpression = NewCaption;
    layout
    {
        modify(Name)
        {
            Editable = false;
            AssistEdit = false;
            Visible = false;
        }

        addfirst(General)
        {
            field(Surname; Rec.Surname)
            {
                ApplicationArea = All;
                Caption = 'Surname';
            }
            field("First Name"; Rec."First Name")
            {
                ApplicationArea = All;
            }
            field("Middle Name"; Rec."Middle Name")
            {
                ApplicationArea = All;
            }

        }

        moveafter("Middle Name"; Name)
        moveafter(Name; "No.")

        moveafter("Company Name"; "Company No.")

        modify("Salesperson Code")
        {
            Caption = 'Account Manager';
            Visible = false;
        }
        addafter("Salesperson Code")
        {
            field("Account Manager"; Rec."Account Manager")
            {
                ApplicationArea = All;
                Caption = 'Account Manager';
            }
        }

        modify("Organizational Level Code")
        {
            Caption = 'Job Title';
        }
        modify("Privacy Blocked")
        {
            Visible = false;
        }
        modify(Minor)
        {
            Visible = false;
        }
        modify("Parental Consent Received")
        {
            Visible = false;
        }

        modify("Registration Number")
        {
            Caption = 'Company Registration No.';
        }

        moveafter("Middle Name"; "Salutation Code")
        moveafter("Salutation Code"; "Organizational Level Code")
        movebefore(ContactIntEntriesSubform; Communication)



    }
    var
        NewCaption: Text[200];
        CompnayRegNoVisibility: Boolean;

    trigger OnAfterGetRecord()
    var
        ContactRec: Record Contact;
    begin
        NewCaption := Rec.Name + ' - ' + FORMAT(Rec."No.");

        if ContactRec.Get(Rec."Company No.") then begin
            rec."Registration Number" := ContactRec."Registration Number";
        end;
    end;
}

