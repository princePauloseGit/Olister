namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Purchases.Document;
using Microsoft.Inventory.Location;
using Microsoft.Foundation.AuditCodes;

tableextension 50208 "Purchase Line Ext" extends "Purchase Line"
{
    fields
    {
        field(50200; "Reason Code"; Code[20])
        {
            Caption = 'Reason Code';
            DataClassification = CustomerContent;
            TableRelation = "Reason Code";
        }
        field(50201; Rejected; Boolean)
        {
            Caption = 'Rejected';
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                Location: Record Location;
            begin
                if Rec.Rejected then begin
                    Location.SetRange(Rejected, true);
                    if Location.FindFirst() then
                        Rec.Validate("Location Code", Location.Code);
                end
                else begin
                    Rec.Validate("Location Code", '');
                    Rec.Validate("Reason Code", '');
                end;
            end;
        }

    }


    trigger OnAfterModify()
    begin
        ReasonCodeError();
    end;

    trigger OnBeforeInsert()
    begin
        ReasonCodeError();
    end;

    procedure ReasonCodeError()
    begin
        if Rejected and ("Reason Code" = '') then
            Error('Reason Code must be filled in when line is rejected.');
    end;
}
