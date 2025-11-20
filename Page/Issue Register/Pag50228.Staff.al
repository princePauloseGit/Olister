namespace ChilternGlobalBC.ChilternGlobalBC;

page 50228 "Staff Details"
{
    ApplicationArea = All;
    Caption = 'All Staff';
    PageType = Card;
    SourceTable = "Staff Details";
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                }
                field(Surname; Rec.Surname)
                {
                }
                field("First Name"; Rec."First Name")
                {
                }
                field("Middle Name"; Rec."Middle Name")
                {
                }
                field("Job Title"; Rec."Job Title")
                {
                }
                field("Cont Tel 1"; Rec."Cont Tel 1")
                {
                }
                field("Cont Tel 2"; Rec."Cont Tel 2")
                {
                }
                field("Email 1"; Rec."Email 1")
                {
                }
                field("Email 2"; Rec."Email 2")
                {
                }
            }
            group("Additional Company Info")
            {
                field(Tel; Rec.Tel)
                {
                }
                field(Fax; Rec.Fax)
                {
                }
                field(Mobile; Rec.Mobile)
                {
                }
                field(Email; Rec.Email)
                {
                }
            }
            group("Bank Info")
            {
                field("Bank Details"; Rec."Bank Details")
                {
                }
                field("Payment Terms"; Rec."Payment Terms")
                {
                }
                field("Vat No."; Rec."Vat No.")
                {
                }
                field("Company Reg No"; Rec."Company Reg No")
                {
                }
            }
        }
        area(FactBoxes)
        {
            part(DocAttachmentFactbox;
            "Doc Attachment FactBox")
            {
                UpdatePropagation = Both;
                Caption = 'Attachment Upload';
                ApplicationArea = All;
                SubPageLink = "Table ID" = const(Database::"Staff Details"), "Document No." = field("No.");
            }
            systempart(Links; Links)
            {
                ApplicationArea = all;
                Visible = true;
            }
            systempart(Notes; Notes)
            {
                ApplicationArea = Notes;
            }
        }
    }
    trigger OnNewRecord(BelowXrec: Boolean)
    var
        myInt: Integer;
    begin
        if Rec."Related No." = '' then begin
            Rec.Insert(true)
        end;
    end;

}
