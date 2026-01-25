pageextension 50291 "Purchase Order Vendor Ext" extends "Purchase Order"
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
