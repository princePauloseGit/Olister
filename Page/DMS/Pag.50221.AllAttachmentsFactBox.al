page 50221 "All Attachments Factbox"
{
    PageType = ListPart;
    SourceTableTemporary = true;
    SourceTable = "All Doc Info Buffer";
    ApplicationArea = All;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    // SourceTableView=sorting("Document Type")
    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("File Name"; Rec."File Name")
                {
                    Editable = false;
                    trigger OnDrillDown()
                    var
                        Selection: Integer;
                        RecDocAttachment: Record "Document Attachment";
                        DocHistory: Record "Doc Attachment History";
                    begin
                        // RecDocAttachment.Get(Rec."Table ID", Rec."Document No.", rec."Document Type", rec."Line No.", Rec.ID);
                        DocHistory.SetRange("Entry No.", Rec.ID);
                        if DocHistory.FindFirst() then begin
                            RecDocAttachment.SetRange(ID, Rec.ID);
                            if RecDocAttachment.FindFirst() then begin
                                if DMSCodeunit.SupportedByFileViewer(RecDocAttachment) then
                                    DMSCodeunit.ViewFile(RecDocAttachment, DocHistory)
                                else
                                    DMSCodeunit.Export(true, RecDocAttachment)
                            end;
                        end;
                    end;
                }
                field("Document Type"; Rec."Document Type") { Caption = 'Attachment Source'; }
                field("Document No."; Rec."Document No.") { }


            }
        }
    }

    var
        DMSCodeunit: Codeunit "DocAttach Ask Metadata";

    procedure LoadFromBlob(No: Code[20]; TableID: Integer)
    var
        Enquiry: Record Enquiry;
        Project: Record Job;
        InStream: InStream;
        SerializedText: Text;
        Id: Integer;
        AttachmentList: List of [Text];
        Line: Text;
        Parts: List of [Text];
        BufferRec: Record "All Doc Info Buffer";
    begin
        BufferRec.DeleteAll();
        Rec.DeleteAll();
        if TableID = Database::Enquiry then begin
            if not Enquiry.Get(No) or not Enquiry."Doc Attachment List".HasValue then
                exit;

            // Clear(Rec);
            Enquiry.CalcFields("Doc Attachment List");
            Enquiry."Doc Attachment List".CreateInStream(InStream);
        end
        else if TableID = Database::Job then begin
            if not Project.Get(No) or not Project."Doc Attachment List".HasValue then
                exit;

            // Clear(Rec);
            Project.CalcFields("Doc Attachment List");
            Project."Doc Attachment List".CreateInStream(InStream);
        end;
        InStream.ReadText(SerializedText);
        AttachmentList := SerializedText.Split('¶');

        foreach Line in AttachmentList do begin
            Parts := Line.Split('|');
            if Parts.Count >= 4 then begin
                Rec.Init();
                Evaluate(Id, Parts.Get(4));
                Rec.ID := Id;
                Rec."Document Type" := Parts.Get(1);
                Rec."Document No." := Parts.Get(2);
                Rec."File Name" := Parts.Get(3);
                Rec.Insert();
                //Rec.Copy(BufferRec);
            end;
        end;

        CurrPage.Update(false);
    end;

}