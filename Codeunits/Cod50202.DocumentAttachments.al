codeunit 50202 "DocAttach Ask Metadata"
{
    internal procedure ViewFile(RecDocAttachment: Record "Document Attachment"; Rec: Record "Doc Attachment History")
    var
        TempBlob: Codeunit "Temp Blob";
        FileInStream: InStream;

    begin
        GetAsTempBlob(TempBlob, Rec);
        TempBlob.CreateInStream(FileInStream);
        File.ViewFromStream(FileInStream, Rec."File Name" + '.' + RecDocAttachment."File Extension", true);
    end;

    procedure GetAsTempBlob(var TempBlob: Codeunit "Temp Blob"; Rec: Record "Doc Attachment History")
    var
        TenantMedia: Record "Tenant Media";
        IsHandled: Boolean;
        RecDocAttachment: Record "Document Attachment";
    begin
        RecDocAttachment.Get(Rec."Table ID", Rec."Document No.", rec."Document Type", rec."Line No.", Rec.ID);
        TenantMedia.SetAutoCalcFields(Content);
        TenantMedia.Get(RecDocAttachment."Document Reference ID".MediaId());
        TempBlob.FromRecord(TenantMedia, TenantMedia.FieldNo(Content));
    end;

    procedure SupportedByFileViewer(var RecDocAttachment: Record "Document Attachment"): Boolean
    var


    begin

        case RecDocAttachment."File Type" of
            RecDocAttachment."File Type"::PDF:
                exit(true);
            RecDocAttachment."File Type"::" ":
                begin
                    if RecDocAttachment."File Extension" <> '' then
                        exit(LowerCase(RecDocAttachment."File Extension") = 'pdf');

                    exit(Lowercase(RecDocAttachment."File Name").EndsWith('pdf'))
                end;
            else
                exit(false);
        end;
    end;

    procedure Export(ShowFileDialog: Boolean; var RecDocAttachment: Record "Document Attachment") Result: Text
    var
        TempBlob: Codeunit "Temp Blob";
        FileManagement: Codeunit "File Management";
        DocumentStream: OutStream;
        FullFileName: Text;
        IsHandled: Boolean;
    begin

        if RecDocAttachment.ID = 0 then
            exit;
        FullFileName := RecDocAttachment."File Name" + '.' + RecDocAttachment."File Extension";
        TempBlob.CreateOutStream(DocumentStream);
        RecDocAttachment.ExportToStream(DocumentStream);
        exit(FileManagement.BLOBExport(TempBlob, FullFileName, ShowFileDialog));
    end;

}