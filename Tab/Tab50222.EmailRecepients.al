table 50222 "Email Recepients"
{
    Caption = 'Email Recepients';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Email; Text[100])
        {
            Caption = 'Email';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[80])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; Email)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; Name, Email) { }
    }
}
