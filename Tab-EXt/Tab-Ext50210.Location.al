namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Location;

tableextension 50210 Location extends Location
{
    fields
    {
        field(50200; Rejected; Boolean)
        {
            Caption = 'Rejected';
            DataClassification = CustomerContent;
        }

    }
}
