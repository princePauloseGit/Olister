table 50210 "Attachment Metadata Buffer"
{
    Caption = 'Attachment Metadata Buffer';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Document Type"; Text[20]) { }
        field(2; "Document No."; Code[20]) { }
        field(3; "File Name"; Text[250]) { }
    }

    keys
    {
        key(PK; "Document No.") { Clustered = true; }
    }
}
