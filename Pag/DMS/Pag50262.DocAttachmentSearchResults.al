namespace TasksActivityModule.TasksActivityModule;

using Microsoft.Foundation.Attachment;

page 50262 "Doc Attachment Search Results"
{
    ApplicationArea = All;
    Caption = 'Search Results';
    PageType = ListPart;
    SourceTable = "Doc Attachment History";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(SearchResults)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    var
                        RecDocAttachment: Record "Document Attachment";
                        DMSCodeunit: Codeunit "DocAttach Ask Metadata";
                    begin
                        RecDocAttachment.Get(Rec."Table ID", Rec."Document No.", Rec."Document Type", Rec."Line No.", Rec.ID);
                        if DMSCodeunit.SupportedByFileViewer(RecDocAttachment) then
                            DMSCodeunit.ViewFile(RecDocAttachment, Rec)
                        else
                            DMSCodeunit.Export(true, RecDocAttachment);
                    end;
                }
                field("Activity Title"; Rec."Activity Title")
                {
                    ApplicationArea = All;
                }
                field("Document Purpose"; Rec."Document Purpose")
                {
                    ApplicationArea = All;
                }
                field("Document Purpose Description"; Rec."Document Purpose Description")
                {
                    ApplicationArea = All;
                }
                field("Document Tag"; Rec."Document Tag")
                {
                    ApplicationArea = All;
                }
                field("Activity Type"; Rec."Activity Type")
                {
                    ApplicationArea = All;
                }
                field("Activity Project No."; Rec."Activity Project No.")
                {
                    ApplicationArea = All;
                }
                field("Date and Time"; Rec."Date and Time")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}