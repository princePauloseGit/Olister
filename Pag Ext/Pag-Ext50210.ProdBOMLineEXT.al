namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Manufacturing.ProductionBOM;
using System.Environment;
using Microsoft.Inventory.Item;

pageextension 50210 ProdBOMLine extends "Production BOM Lines"
{
    layout
    {
        addbefore(Type)
        {
            field(DocImage; MediaRec.Content)
            {
                Caption = 'Photo';
                ApplicationArea = all;
                // Editable = false;
            }
        }

    }

    var
        MediaRec: Record "Tenant Media";
        Item: Record Item;



    trigger OnAfterGetRecord()
    begin
        if Rec."Production BOM No." <> '' then begin
            if (Rec."No." <> '') and (Rec.Type = Rec.Type::Item) then begin
                Item.Get(Rec."No.");
                if Item.Picture.Count > 0 then begin
                    MediaRec.Get(Item.Picture.Item(1));
                    MediaRec.CalcFields(Content);
                end else
                    Clear(MediaRec);

            end;
        end else
            Clear(MediaRec);
    end;
}
