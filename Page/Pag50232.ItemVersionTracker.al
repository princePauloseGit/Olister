namespace ChilternGlobalBC.ChilternGlobalBC;
using Microsoft.Inventory.Item;

page 50232 "Item Version Tracker"
{
    ApplicationArea = All;
    Caption = 'Item Version Tracker';
    PageType = List;
    SourceTable = "Item Version Tracker";
    UsageCategory = Lists;
    SourceTableTemporary = true;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Item No"; Rec."Item No")
                {
                    ToolTip = 'Specifies the value of the Item No field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        item: Record Item;
                    begin
                        if item.Get(Rec."Item No") then begin
                            PAGE.Run(PAGE::"Item Card", item);
                        end;
                    end;
                }
                field("Next Version"; Rec."Next Version")
                {
                    ToolTip = 'Specifies the value of the Next Version field.', Comment = '%';
                    trigger OnDrillDown()
                    var
                        item: Record Item;
                    begin
                        if item.Get(Rec."Next Version") then begin
                            PAGE.Run(PAGE::"Item Card", item);
                        end;
                    end;
                }
                field("Created date"; Rec."Created date")
                {
                    ToolTip = 'Specifies the value of the Created date field.', Comment = '%';
                }
                field("Created By"; Rec."Created By")
                {
                    ToolTip = 'Specifies the value of the Created By field.', Comment = '%';
                }
                field("Serial No."; Rec."Serial No.")
                {
                    ToolTip = 'Specifies the value of the Serial No. field.', Comment = '%';
                }
            }
        }
    }
}
