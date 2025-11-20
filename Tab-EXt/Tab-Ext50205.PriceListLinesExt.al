namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Pricing.PriceList;

tableextension 50205 "Price List Lines Ext" extends "Price List Line"
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
