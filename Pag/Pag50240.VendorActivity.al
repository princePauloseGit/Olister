namespace ALProject.ALProject;

using Microsoft.Purchases.Vendor;

page 50240 "VendorActivity"
{
    ApplicationArea = All;
    Caption = 'Vendor Activity';
    PageType = CardPart;
    SourceTable = Vendor;

    layout
    {
        area(Content)
        {
            cuegroup(Vendors)
            {
                field(VendorsAll; VendorsAll)
                {

                    ToolTip = 'View Vendor All list';
                    Caption = 'Vendors All';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Vendor: Record Vendor;
                        Vendorlist: Page "Vendor List";
                    begin

                        Vendorlist.SetTableView(Vendor);
                        Vendorlist.Run();
                    end;

                }
                field(Vendoropen; VendorOpen)
                {
                    ToolTip = 'View Open Vendor Activity list';
                    Caption = 'Open Vendors Activity ';
                    ApplicationArea = All;
                    trigger OnDrillDown()
                    var
                        Vendor: Record Vendor;
                        Vendorlist: Page "Vendor List";
                    begin
                        Vendor.SetRange(Status, Vendor.Status::"Live / Normal");
                        Vendorlist.SetTableView(Vendor);
                        Vendorlist.Run();
                    end;
                }

            }
        }


    }
    trigger OnAfterGetCurrRecord()
    var
        Vendor: Record Vendor;
        Vendor1: Record Vendor;
    begin
        Vendor.Reset();
        Vendor.SetRange(Status, Vendor.Status::"Live / Normal");
        VendorOpen := Vendor.Count();

        Vendor1.Reset();
        VendorsAll := Vendor1.Count();


    end;


    var
        VendorOpen: Integer;
        VendorsAll: Integer;
}
