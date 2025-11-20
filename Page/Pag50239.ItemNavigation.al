namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Item;

page 50239 "Item Navigation"
{
    ApplicationArea = All;
    Caption = 'Item Navigation';
    PageType = CardPart;
    SourceTable = Item;

    layout
    {
        area(Content)
        {
            cuegroup(General)
            {
                ShowCaption = false;
                Caption = 'General';

                field("All Projects"; Rec."All Projects")
                {
                    ToolTip = 'Specifies the value of the All Projects field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    DrillDownPageId = "Item List";

                }
                field("Live Projects"; Rec."Live Projects")
                {
                    ToolTip = 'Specifies the value of the Live Projects field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    DrillDownPageId = "Item List";
                }
            }
        }
    }
}
