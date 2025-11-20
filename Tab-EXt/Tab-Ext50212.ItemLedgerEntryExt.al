namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Ledger;
using Microsoft.Foundation.AuditCodes;

tableextension 50212 "Item Ledger Entry Ext" extends "Item Ledger Entry"
{
    fields
    {
        field(50200; "Rejection Reason Code"; Code[20])
        {
            Caption = 'Rejection Reason Code';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code";
            ValidateTableRelation = false;
        }
        field(50201; Rejected; Boolean)
        {
            Caption = 'Rejected';
            DataClassification = CustomerContent;
        }

    }
}
