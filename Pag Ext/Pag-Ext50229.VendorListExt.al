namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Purchases.Vendor;
using Microsoft.CRM.Interaction;

pageextension 50229 VendorListExt extends "Vendor List"
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
        modify(Contact)
        {
            Caption = 'Primary Contact';
        }

        addafter(Contact)
        {
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
        addafter("No.")
        {
            field(Status; Rec.Status)
            {
                ApplicationArea = All;
                Caption = 'Status';
            }
            field(Type; Rec.Type)
            {
                ApplicationArea = All;
                Caption = 'Customer Type';
            }

        }

        addlast(Control1)
        {
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
                    Rec_Interaction.SetFilter("Contact No.", '%1..', Rec."Primary Contact No.");
                    if Rec_Interaction.FindFirst() then
                        PAGE.Run(PAGE::"Interaction Log Entries", Rec_Interaction);
                end;
            }
        }
        modify("Purchaser Code")
        {
            Caption = 'Account Manager';
            Visible = true;
        }
        moveafter(Type; "Purchaser Code")


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
