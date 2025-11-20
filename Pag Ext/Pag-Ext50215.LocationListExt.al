pageextension 50215 "Location List Ext" extends "Location List"
{
    layout
    {
        addafter(Name)
        {
            field(Rejected; Rec.Rejected)
            {
                ApplicationArea = all;
                Editable = false;
                Caption = 'Use as Rejected';
            }
        }
    }
}
