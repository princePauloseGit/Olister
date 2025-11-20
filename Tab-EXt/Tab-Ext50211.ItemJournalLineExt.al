namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Journal;

tableextension 50211 "Item Journal Line Ext" extends "Item Journal Line"
{
    fields
    {
        field(50200; "Rejection Reason Code"; Code[20])
        {
            Caption = 'Rejection Reason Code';
            DataClassification = CustomerContent;
        }
        field(50201; Rejected; Boolean)
        {
            Caption = 'Rejected';
            DataClassification = CustomerContent;
        }

    }
}
