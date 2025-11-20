namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Manufacturing.ProductionBOM;

pageextension 50209 ProdBOMList extends "Production BOM List"
{
    actions
    {
        addlast(reporting)
        {
            action(QuantityExplosionofBOMReport)
            {
                ApplicationArea = All;
                Caption = 'Quantity Explosion of BOM Report';
                Image = Print;
                Promoted = true;
                PromotedCategory = Report;
                PromotedOnly = true;
                ToolTip = 'Print Quantity Explosion of BOM Report.';
                RunObject = Report QuantityExplosionofBOMReport;
            }
        }
        modify("Quantity Explosion of BOM")
        {
            Visible = false;
        }
    }
}
