table 50212 "Create Product"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Enq No"; Code[20])
        {
            DataClassification = CustomerContent;
            //  AutoIncrement = true;
        }
        field(2; Description; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Base Unit of Measure"; Code[10])
        {

        }
        field(4; "Item Category Code"; Code[20])
        {


        }
        field(5; "Purchasing Code"; Code[10])
        {

        }

        field(7; "Line No"; Integer)
        {

        }
    }

    keys
    {
        key(Key1; "Enq No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }



}