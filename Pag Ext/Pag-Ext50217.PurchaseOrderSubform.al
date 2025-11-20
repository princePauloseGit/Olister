namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Purchases.Document;

pageextension 50217 "Purchase Order Subform" extends "Purchase Order Subform"
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
