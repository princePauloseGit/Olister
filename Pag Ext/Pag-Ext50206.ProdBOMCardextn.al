namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Item.Picture;

pageextension 50206 Prod_BOM_CardExtn extends "Production BOM"
{
    layout
    {
        addfirst(factboxes)
        {
            part(Prod_Bom_Picture; Prod_Bom_Picture)
            {
                ApplicationArea = all;
                Caption = 'Item Picture';
                // SubPageLink = "Production BOM No." = field("No."), "Production BOM No." = filter(<> '');
            }
        }
    }
    trigger OnAfterGetRecord()
    var
        RecItem: Record Item;
    begin
        if Rec."No." <> '' then begin
            RecItem.SetRange("Production BOM No.", Rec."No.");
            If RecItem.FindFirst() then
                CurrPage.Prod_Bom_Picture.Page.LoadFromBOM(RecItem."No.")

        end
        else
            CurrPage.Prod_Bom_Picture.Page.LoadFromBOM('');
    end;

    // trigger OnOpenPage()
    // var
    //     RecItem: Record Item;
    // begin
    //     if Rec."No." <> '' then begin
    //         RecItem.SetRange("Production BOM No.", Rec."No.");
    //         If RecItem.FindFirst() then
    //             CurrPage.Prod_Bom_Picture.Page.LoadFromBOM(RecItem."No.")

    //     end
    //     else
    //         CurrPage.Prod_Bom_Picture.Page.LoadFromBOM('');
    // end;
    var

}

