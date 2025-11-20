
page 50233 "Job Picture"

{
    Caption = 'Job Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Job;

    layout
    {
        area(content)
        {
            field(Image; Rec.Image)
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Camera;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                    InStr: InStream;

                begin
                    UploadIntoStream(SelectPictureTxt, '', '', ClientFileName, InStr);
                    Clear(Rec.Image);
                    Rec.Image.ImportStream(InStr, ClientFileName, MimeTypeTok);
                    Rec.Modify(true);
                    // Rec.TestField("No.");
                    // // if Rec.Description = '' then
                    // //     Error(MustSpecifyNameErr);

                    // if Rec.Image.HasValue() then
                    //     if not Confirm(OverrideImageQst) then
                    //         exit;

                    // FileName := UploadFile(SelectPictureTxt, ClientFileName);
                    // if FileName = '' then
                    //     exit;

                    // Clear(Rec.Image);
                    // Rec.Image.ImportFile(FileName, ClientFileName);
                    // if not Rec.Modify(true) then
                    //     Rec.Insert(true);

                    // if FileManagement.DeleteServerFile(FileName) then;
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    Rec.TestField("No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec.Image);
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Camera: Codeunit Camera;
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        MustSpecifyNameErr: Label 'You must specify a customer name before you can import a picture.';
        MimeTypeTok: Label 'image/jpeg', Locked = true;
    // PathHelper: DotNet Path;


    procedure TakeNewPicture()
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.Find();
        Rec.TestField("No.");
        Rec.TestField(Description);

        if Rec.Image.HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec.Image);
            Rec.Image.ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true)
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Image.HasValue;
    end;

    procedure IsCameraAvailable(): Boolean
    begin
        exit(Camera.IsAvailable());
    end;

    procedure UploadFile(WindowTitle: Text[50]; ClientFileName: Text) ServerFileName: Text
    var
        "Filter": Text;
        fiileManagement: Codeunit "File Management";
    begin
        Filter := fiileManagement.GetToFilterText('', ClientFileName);

        if fiileManagement.GetFileNameWithoutExtension(ClientFileName) = '' then
            ClientFileName := '';

        ServerFileName := ClientFileName;
    end;


}

