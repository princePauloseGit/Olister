namespace TasksActivityModule.TasksActivityModule;
using ChilternGlobalBC.ChilternGlobalBC;

page 50210 Enquiries
{
    ApplicationArea = All;
    Caption = 'Enquiries';
    PageType = List;
    SourceTable = Enquiry;
    UsageCategory = Lists;
    Editable = false;
    CardPageId = 50217;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Start Date"; Rec."Start Date") { }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.', Comment = '%';
                }
                field("Enquiry No."; Rec."Enquiry No.")
                {
                    ToolTip = 'Specifies the value of the Enquiry No. field.', Comment = '%';
                    trigger OnDrillDown()
                    begin
                        OpenEnquiryCard();
                    end;
                }

                field("Customer Name"; Rec."Customer Name")
                {
                    ToolTip = 'Specifies the value of the Customer Name field.', Comment = '%';
                }

                field("Customer No."; Rec."Customer No.")
                {
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = '%';
                }

                field(Status; Rec.Status) { }
                field("Review Date"; Rec."Review Date") { }

            }
        }
        area(FactBoxes)
        {
            Part(EnquiryNavFactbox; "Enquiry Navigation Factbox")
            {
                Caption = 'Enquiry Navigation';
                ApplicationArea = All;
                SubPageLink = "Enquiry No." = field("Enquiry No.");
            }
        }
    }
    procedure OpenEnquiryCard()
    var
        Enquiry: Record Enquiry;
    begin
        if Enquiry.Get(Rec."Enquiry No.") then begin
            Page.Run(Page::"Enquiry", Enquiry);
        end;
    end;
}