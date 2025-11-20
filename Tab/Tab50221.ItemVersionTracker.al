table 50221 "Item Version Tracker"
{
    Caption = 'Item Version Tracker';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Item No"; Code[20])
        {
            Caption = 'Item No';
        }
        field(2; "Next Version"; Code[20])
        {
            Caption = 'Next Version';
        }
        field(3; "Created date"; DateTime)
        {
            Caption = 'Created date';
        }
        field(4; "Created By"; Text[50])
        {
            Caption = 'Created By';
        }
        field(5; "Serial No."; Integer)
        {
            Caption = 'Serial No.';
        }
    }
    keys
    {
        key(PK; "Item No")
        {
            Clustered = true;
        }
    }
}
