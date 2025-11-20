namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Ledger;

pageextension 50219 "Item Ledger Entries Ext" extends "Item Ledger Entries"
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
            field("Rejection Reason Code"; Rec."Rejection Reason Code")
            {
                ApplicationArea = all;
                Caption = 'Reason Code';
            }
        }
    }
}
