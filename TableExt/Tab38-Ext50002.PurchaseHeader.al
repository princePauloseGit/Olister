tableextension 50294 "Purchase Header Vendor Ext" extends "Purchase Header"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            Caption = 'Buy-from Supplier No.';
        }
        modify("Buy-from Vendor Name")
        {
            Caption = 'Buy-from Supplier Name';
        }
        modify("Pay-to Vendor No.")
        {
            Caption = 'Pay-to Supplier No.';
        }
        modify("Pay-to Name")
        {
            Caption = 'Pay-to Supplier Name';
        }
    }
}
