page 50264 "Document Management Setup"
{
    ApplicationArea = All;
    Caption = 'Document Management Setup';
    PageType = Card;
    SourceTable = "Document Management Setup";
    UsageCategory = Administration;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General Settings';

                field("Upload Mandatory"; Rec."Upload Mandatory")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if uploading documents is mandatory.';
                }
                field("Document Purpose Mandatory"; Rec."Document Purpose Mandatory")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies if selecting a document purpose is mandatory when uploading documents.';
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        DocMgtSetup: Record "Document Management Setup";
    begin
        if not DocMgtSetup.Get() then begin
            DocMgtSetup.Init();
            DocMgtSetup."Primary Key" := '';
            DocMgtSetup.Insert();
        end;
        Rec := DocMgtSetup;
    end;
}