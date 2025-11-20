table 50220 "Project vendors"
{
    Caption = 'Project vendors';
    DataClassification = CustomerContent;


    fields
    {
        field(1; "Project No"; Code[20])
        {
            Caption = 'Project No';
        }
        field(2; "Activities"; Integer)
        {
            Caption = 'Activity No';
            FieldClass = FlowField;
            CalcFormula = Count(AANActivity where("Project No." = field("Project No"), "Vendor No." = field("Vendor No")));
        }
        field(3; "Vendor No"; Code[20])
        {
            Caption = 'Vendor No';
        }
        field(4; "Vendor Name"; Text[100])
        {
            trigger OnLookup()
            var
                VendorName: Text;
            begin
                VendorName := "Vendor Name";
                LookupVendorName(VendorName);
                "Vendor Name" := CopyStr(VendorName, 1, MaxStrLen("Vendor Name"));
                Validate("Vendor Name");
            end;

            trigger OnValidate()
            begin
                if Vendor."No." <> '' then begin
                    Validate("Vendor No", Vendor."No.");
                end;
            end;

        }
        field(5; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            DataClassification = CustomerContent;
        }
        field(6; "Item Description"; Text[100])
        {
            Caption = 'Item Description';
            FieldClass = FlowField;
            CalcFormula = lookup(Item.Description where("No." = field("Item No.")));
        }
        field(7; LineNo; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Project No", "Vendor No")
        {
            Clustered = true;
        }
    }

    procedure LookupVendorName(var VendorName: Text): Boolean
    var

        LookupStateManager: Codeunit "Lookup State Manager";
        RecVariant: Variant;
        SearchVendorName: Text;
    begin
        SearchVendorName := VendorName;
        // Vendor.SetRange(Blocked, Vendor.Blocked::" ");
        if "Vendor No" <> '' then
            Vendor.Get("Vendor No");

        if Vendor.SelectVendor(Vendor) then begin
            if Rec."Vendor Name" = Vendor.Name then
                VendorName := SearchVendorName
            else
                VendorName := Vendor.Name;
            RecVariant := Vendor;
            LookupStateManager.SaveRecord(RecVariant);
            exit(true);
        end;
    end;


    var
        Vendor: Record Vendor;
}
