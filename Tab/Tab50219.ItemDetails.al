table 50219 "Item Details"
{
    Caption = 'Item Details';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item Type"; Code[20])
        {
            Caption = 'Item Type';
            TableRelation = "Product Type";
        }
        field(2; "Item Category"; Code[20])
        {
            Caption = 'Item Category';
        }
        field(3; "Item Group Code"; Code[20])
        {
            Caption = 'Item Group Code';
        }
        field(4; "Item Range"; Code[20])
        {
            Caption = 'Item Range';
        }
    }
    keys
    {
        key(PK; "Item Type", "Item Category", "Item group Code", "Item range")
        {
            Clustered = true;
        }
    }
}
