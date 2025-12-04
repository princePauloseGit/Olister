page 50220 "Doc Attachment Card"
{
    PageType = Card;
    SourceTable = "Doc Attachment History";
    Caption = 'Attach Document';
    ApplicationArea = All;
    UsageCategory = Lists;
    InsertAllowed = false;

    layout
    {
        area(content)
        {
            group("Document Details")
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'Entry No.';
                }
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Caption = 'File Name';
                }
                field("Document Purpose"; Rec."Document Purpose")
                {
                    ApplicationArea = All;
                    TableRelation = "Document Purpose";
                    AssistEdit = true;
                    ShowMandatory = DocumentPurposeMandatory;

                    trigger OnAssistEdit()
                    var
                        DocPurpose: Record "Document Purpose";
                        DocPurposeList: Page "Document Purpose List";
                    begin
                        if DocPurposeList.RunModal() = Action::OK then begin
                            DocPurposeList.GetRecord(DocPurpose);
                            Rec."Document Purpose" := DocPurpose.Code;
                            CurrPage.Update();
                        end;
                    end;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Document Purpose Description"; Rec."Document Purpose Description")
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    Editable = true;
                    ToolTip = 'Enter a custom description for the document purpose.';
                }
                field("Document Tag"; Rec."Document Tag")
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    trigger OnAssistEdit()
                    var
                        TagMaster: Record TagMaster;
                        TagsText: Text;
                    begin
                        if Page1.RunModal() = Action::OK then begin
                            Page1.SetSelectionFilter(TagMaster);
                            if TagMaster.FindSet() then begin
                                repeat
                                    if TagsText = '' then
                                        TagsText := TagMaster.Tag
                                    else
                                        TagsText := TagsText + ',' + TagMaster.Tag;
                                until TagMaster.Next() = 0;
                                Rec."Document Tag" := TagsText;
                                Clear(Page1);
                                CurrPage.Update();
                            end;
                        end;
                    end;
                }
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        ActivityRec: Record AANActivity;
        DocMgtSetup: Record "Document Management Setup";
        DocAttachHistory: Record "Doc Attachment History";
    begin
        if CloseAction = Action::OK then begin
            DocMgtSetup := DocMgtSetup.GetSetup();

            if DocMgtSetup."Document Purpose Mandatory" and (Rec."Document Purpose" = '') then
                Error('Document Purpose is mandatory. Please select a document purpose before saving.');

            if DocMgtSetup."Upload Mandatory" then begin
                DocAttachHistory.SetRange("Table ID", Rec."Table ID");
                DocAttachHistory.SetRange("Document No.", Rec."Document No.");
                if DocAttachHistory.IsEmpty() then
                    Error('Document upload is mandatory. Please upload at least one document before proceeding.');
            end;

            repeat
                // Store all AANActivity information
                if Rec."Table ID" = Database::AANActivity then begin
                    if ActivityRec.Get(Rec."Document No.") then begin
                        Rec."Activity Title" := ActivityRec."Activity Title";
                        Rec."Activity Type" := ActivityRec."Activity type";
                        Rec."Activity Created By" := ActivityRec."Created By";
                        Rec."Activity Status" := ActivityRec.Status;
                        Rec."Activity Assigned To" := ActivityRec."Assigned To";
                        Rec."Activity Accountable" := ActivityRec.Accountable;
                        Rec."Activity Due Date" := ActivityRec."Due Date";
                        Rec."Activity Project No." := ActivityRec."Project No.";

                        ActivityRec.CalcFields("Project Name");
                        Rec."Activity Project Name" := ActivityRec."Project Name";

                        Rec."Activity Enquiry No." := ActivityRec."Enquiry No.";

                        ActivityRec.CalcFields("Enquiry Name");
                        Rec."Activity Enquiry Name" := ActivityRec."Enquiry Name";

                        Rec."Activity Related Issue No" := ActivityRec."Related Issue No";
                        Rec."Activity Tags" := ActivityRec.Tags;

                        Rec."Vendor No." := ActivityRec."Vendor No.";
                        Rec."Customer No." := ActivityRec."Customer No.";
                        Rec."Item No." := ActivityRec."Item No.";
                    end;
                end;

                Rec.Modify(true);
            until Rec.Next() = 0;
        end;
    end;

    trigger OnOpenPage()
    var
        DocMgtSetup: Record "Document Management Setup";
    begin
        DocMgtSetup := DocMgtSetup.GetSetup();
        DocumentPurposeMandatory := DocMgtSetup."Document Purpose Mandatory";
        UploadMandatory := DocMgtSetup."Upload Mandatory";
    end;

    procedure getdata(var g: Record "Doc Attachment History")
    begin
        // This procedure can be used to set data if needed
    end;

    var
        Page1: Page tag;
        HasNextRecord: Boolean;
        HasPreviousRecord: Boolean;
        DocumentPurposeMandatory: Boolean;
        UploadMandatory: Boolean;
        ShowRelatedInfo: Boolean;
}