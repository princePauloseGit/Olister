namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Projects.Project.Job;
using System.IO;

page 50247 "Project Picture"
{
    Caption = 'Project Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Job;
    layout
    {
        area(content)
        {
            field(Picture; Rec.Picture)
            {
                ApplicationArea = All;
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the Project.';
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';
                Visible = HideActions = FALSE;
                trigger OnAction()
                begin
                    ImportFromDevice();
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';
                Visible = HideActions = FALSE;
                trigger OnAction()
                begin
                    DeleteItemPicture();
                end;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    var
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        HideActions: Boolean;
        MustSpecifyDescriptionErr: Label 'You must add a description to the Project before you can import a picture.';

    procedure TakeNewPicture()
    begin
        Rec.Find();
        Rec.TestField("No.");
        Rec.TestField(Description);
    end;

    procedure ImportFromDevice()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;
        InStr: InStream;
    begin
        Rec.Find();
        Rec.TestField("No.");
        if Rec.Description = '' then
            Error(MustSpecifyDescriptionErr);
        if Rec.Picture.Count > 0 then
            if not Confirm(OverrideImageQst) then
                Error('');
        ClientFileName := '';
        UploadIntoStream(SelectPictureTxt, '', '', ClientFileName, InStr);
        if ClientFileName <> '' then
            FileName := FileManagement.GetFileName(ClientFileName);
        //FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
        if FileName = '' then
            Error('');
        Clear(Rec.Picture);
        Rec.Picture.ImportStream(InStr, FileName);
        //Picture.ImportFile(FileName, ClientFileName);
        Rec.Modify(true);
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Picture.Count <> 0;
    end;

    procedure DeleteItemPicture()
    begin
        Rec.TestField("No.");
        if not Confirm(DeleteImageQst) then
            exit;
        Clear(Rec.Picture);
        Rec.Modify(true);
    end;
}