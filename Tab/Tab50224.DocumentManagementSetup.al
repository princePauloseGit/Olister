table 50224 "Document Management Setup"
{
    Caption = 'Document Management Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = SystemMetadata;
        }
        field(2; "Upload Mandatory"; Boolean)
        {
            Caption = 'Upload Mandatory';
            DataClassification = CustomerContent;
        }
        field(3; "Document Purpose Mandatory"; Boolean)
        {
            Caption = 'Document Purpose Description Mandatory';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure GetSetup(): Record "Document Management Setup"
    var
        DocMgtSetup: Record "Document Management Setup";
    begin
        if not DocMgtSetup.Get() then begin
            DocMgtSetup.Init();
            DocMgtSetup."Primary Key" := '';
            DocMgtSetup.Insert();
        end;
        exit(DocMgtSetup);
    end;
}