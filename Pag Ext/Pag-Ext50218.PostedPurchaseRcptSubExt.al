namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Purchases.History;

pageextension 50218 "Posted Purchase Rcpt. Sub Ext " extends "Posted Purchase Rcpt. Subform"
{
    layout
    {
        addafter("Location Code")
        {
            field(Rejected; Rec.Rejected)
            {
                ApplicationArea = all;
                Caption = 'Rejected';
            }
            field("Reason Code"; Rec."Reason Code")
            {
                ApplicationArea = all;
                Caption = 'Reason Code';
            }
        }
    }
}
