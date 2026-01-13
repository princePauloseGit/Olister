namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.CRM.Contact;
using Microsoft.CRM.Team;

tableextension 50214 ContactExt extends Contact
{
    DataCaptionFields = Name, "No.";

    fields
    {
        field(50000; "Account Manager"; Text[100])
        {
            Caption = 'Account Manager';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Salesperson/Purchaser".Name where("Code" = FIELD("Salesperson Code")));
        }
    }
}
