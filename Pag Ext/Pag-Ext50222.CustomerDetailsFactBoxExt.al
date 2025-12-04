namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Sales.Customer;

pageextension 50222 "Customer Details FactBox Ext" extends "Customer Details FactBox"
{
    layout
    {
        modify(Name)
        {
            Caption = 'Customer Name';
        }
        moveafter(Name; Contact)

        addafter(Contact)
        {

            field("Primary Contact No."; Rec."Primary Contact No.")
            {
                Caption = 'Customer Contact No';
            }
            field("Mobile Phone No."; Rec."Mobile Phone No.")
            {
                Caption = 'Customer Mobile No';
            }

        }
        moveafter("Mobile Phone No."; "E-Mail")
    }
}
