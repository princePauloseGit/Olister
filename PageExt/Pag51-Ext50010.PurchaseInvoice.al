pageextension 50290 "Purchase Invoice Vendor Ext" extends "Purchase Invoice"
{
    layout
    {
        modify("Buy-from Vendor No.")
        {
            Caption = 'Buy-from Supplier No.';
        }
        modify("Buy-from Vendor Name")
        {
            Caption = 'Buy-from Supplier Name';
        }
    }
}
