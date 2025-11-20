table 50209 "All Doc Info Buffer"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document Type"; Text[20])
        {

        }
        field(2; "Document No."; Code[20]) { }
        field(3; "File Name"; Text[250]) { }
        field(4; ID; Integer) { }
    }
    keys
    {
        key(pk; ID, "Document No.") { }
    }
}