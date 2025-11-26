namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Inventory.Item;
using Microsoft.Inventory.Item.Picture;
using TasksActivityModule.TasksActivityModule;
using Microsoft.Projects.Project.Job;

pageextension 50206 Prod_BOM_CardExtn extends "Production BOM"
{
    layout
    {
        addafter("No.")
        {
            field("Project No."; Rec."Project No.")
            {
                Editable = true;
                Caption = 'Project No';
                ApplicationArea = all;
                trigger OnDrillDown()
                var
                    Job: Record Job;
                begin
                    if Rec."Project No." <> '' then begin
                        if Job.Get(Rec."Project No.") then
                            Page.Run(Page::"Job Card", Job);
                    end;
                end;
            }
        }

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

    var

}

