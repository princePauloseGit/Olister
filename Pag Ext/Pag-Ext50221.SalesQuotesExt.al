namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Sales.Document;

pageextension 50221 "Sales Quotes Ext" extends "Sales Quotes"
{
    layout
    {
        movebefore("Sell-to Customer No."; "Sell-to Customer Name")
        movebefore("No."; "Posting Date")
        movebefore(Control1902018507; Control1900316107)
    }
}
