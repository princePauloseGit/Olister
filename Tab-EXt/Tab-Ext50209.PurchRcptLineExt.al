namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Purchases.History;
using Microsoft.Foundation.AuditCodes;

tableextension 50209 "Purch. Rcpt. Line Ext" extends "Purch. Rcpt. Line"
{
    fields
    {
        field(50200; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code";

        }
        field(50201; Rejected; Boolean)
        {
            Caption = 'Rejected';
            DataClassification = CustomerContent;
        }
    }
}
