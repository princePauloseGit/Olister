table 50208 TagMaster
{
    Caption = 'TagMaster';
    DataClassification = CustomerContent;

    fields
    {
        field(1; EntryNo; Integer)
        {
            Caption = 'EntryNo';
            AutoIncrement = true;
        }
        field(2; Tag; Text[250])
        {
            Caption = 'Tag';
        }
    }
    keys
    {
        key(PK; EntryNo, Tag)
        {
            Clustered = true;
        }
    }
}