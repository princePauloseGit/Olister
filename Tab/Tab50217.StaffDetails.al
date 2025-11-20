table 50217 "Staff Details"
{
    Caption = 'Staff Details';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Surname"; Text[100])
        {
        }
        field(2; "Cont Tel 1"; Text[30])
        {
        }
        field(3; "Email 1"; Text[80])
        {
        }

        field(5; "Cont Tel 2"; Text[30])
        {
        }
        field(6; "Job Title"; Code[20])
        {
        }
        field(7; "No."; Code[10])
        {
            Caption = 'No.';
            Editable = false;
            trigger OnValidate()
            var
                Staff: Record "Staff Details";
            begin
                if "No." <> xRec."No." then
                    if not Staff.Get(Rec."No.") then begin
                        TnASetup.Get();
                        NoSeriesMgt.TestManual(TnASetup."Activity No");
                        "No." := '';
                    end;
            end;
        }
        field(8; "Related No."; Code[10])
        {
            Caption = 'Related No.';
            Editable = false;
        }
        field(9; "Table Name"; Text[30])
        {
            Caption = 'Table Name';
            DataClassification = CustomerContent;
        }
        field(10; "First Name"; Text[100])
        {
        }
        field(11; "Middle Name"; Text[100])
        {

        }
        field(12; "Email 2"; Text[80])
        {
        }
        field(13; "Tel"; Text[30])
        {
        }
        field(14; "Fax"; Text[30])
        {
        }
        field(15; "Mobile"; Text[30])
        {

        }
        field(16; "Email"; Text[80])
        {
        }
        field(17; "Bank Details"; Text[2048])
        {
        }
        field(18; "Payment Terms"; Code[10])
        {
        }
        field(19; "Vat No."; Text[30])
        {

        }
        field(20; "Company Reg No"; Text[30])
        {
        }


    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        noseriesline: Record "No. Series Line";
    begin
        if "No." = '' then begin
            TnASetup.Get();
            TnASetup.TestField("Staff No");
            "No." := NoSeriesMgt.GetNextNo(TnASetup."Staff No");
        end;
    end;


    var
        TnASetup: Record "Tasks & Activities Setup";
        NoSeriesMgt: Codeunit "No. Series";
}
