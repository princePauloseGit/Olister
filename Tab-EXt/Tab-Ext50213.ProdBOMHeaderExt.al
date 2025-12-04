namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Manufacturing.ProductionBOM;

tableextension 50213 "Prod. BOM Header Ext" extends "Production BOM Header"
{
    fields
    {
        field(50200; "Project No."; Code[20])
        {
            Caption = 'Project No.';
            DataClassification = CustomerContent;
        }

    }
}
