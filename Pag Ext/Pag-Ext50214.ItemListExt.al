namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Item;

pageextension 50214 "Item List Ext" extends "Item List"
{
    layout
    {
        movebefore("No."; Description)
        addbefore(Control1901314507)
        {
            part(itemNavigation; "Item Navigation")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
                Caption = 'Item Navigation';
            }
        }
    }
}
