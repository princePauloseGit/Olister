tableextension 50292 "Supplier Table Ext" extends Vendor
{
    fields
    {
        modify("No.")
        {
            Caption = 'Supplier No.';
        }
        modify(Name)
        {
            Caption = 'Supplier Name';
        }
        modify("Vendor Posting Group")
        {
            Caption = 'Supplier Posting Group';
        }
    }
}
