tableextension 50293 "Supplier Ledger Entry Ext" extends "Vendor Ledger Entry"
{
    fields
    {
        modify("Vendor No.")
        {
            Caption = 'Supplier No.';
        }
        modify("Vendor Name")
        {
            Caption = 'Supplier Name';
        }
    }
}
