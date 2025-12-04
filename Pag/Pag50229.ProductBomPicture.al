namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Item;
using System.Text;
using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Integration.Entity;
using System.Device;
using System.IO;

page 50229 Prod_Bom_Picture
{
    Caption = 'Prod Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = "Production BOM Header";

    layout
    {
        area(content)
        {
            field(Picture; Item.Picture)
            {
                ApplicationArea = Invoicing, Basic, Suite;
                ShowCaption = false;
                ToolTip = 'Specifies the picture that has been inserted for the item.';
            }
        }
    }


    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Item: Record Item;
        Camera: Codeunit Camera;
        CameraAvailable: Boolean;

    procedure TakeNewPicture()
    begin
        Rec.Find();
        Rec.TestField("No.");
        Rec.TestField(Description);

    end;

    // [Scope('OnPrem')]
    procedure ImportFromDevice()
    var
        FileManagement: Codeunit "File Management";
        FileName: Text;
        ClientFileName: Text;
    begin
        // Rec.Find();
        // Rec.TestField("No.");
        // if Rec.Description = '' then
        //     Error(MustSpecifyDescriptionErr);

        // if Rec.Picture.Count > 0 then
        //     if not Confirm(OverrideImageQst) then
        //         Error('');

        // ClientFileName := '';
        // FileName := FileManagement.UploadFile(SelectPictureTxt, ClientFileName);
        // if FileName = '' then
        //     Error('');

        // Clear(Rec.Picture);
        // Rec.Picture.ImportFile(FileName, ClientFileName);
        // Rec.Modify(true);
        // OnImportFromDeviceOnAfterModify(Rec);

        // if FileManagement.DeleteServerFile(FileName) then;
    end;




    [IntegrationEvent(false, false)]
    local procedure OnAfterDeleteItemPicture(var Item: Record Item)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterTakeNewPicture(var Item: Record Item; IsPictureAdded: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnImportFromDeviceOnAfterModify(var Item: Record Item)
    begin
    end;

    procedure LoadFromBOM(ProdBOMNo: Code[20])
    var
        myInt: Integer;
    begin
        Item.SetFilter("Production BOM No.", ProdBOMNo);
        if item.FindFirst() then
            CurrPage.Update();
        // if item.FindFirst() then
        //     Item.CalcFields(Picture);

    end;

}

