namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Location;

pageextension 50216 "Location Card Ext" extends "Location Card"
{
    layout
    {
        addafter("Use As In-Transit")
        {
            field(Rejected; Rec.Rejected)
            {
                ApplicationArea = all;
                Caption = 'Use as Rejected';
            }
        }
    }
}
