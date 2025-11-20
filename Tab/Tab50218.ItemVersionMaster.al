table 50218 "Item Version Master"
{
    Caption = 'Item Version Master';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.';
        }
        field(2; "Previous Version"; Code[20])
        {
            Caption = 'Previous Version';
        }

    }
    keys
    {
        key(PK; "Item No.")
        {
            Clustered = true;
        }
    }
}
