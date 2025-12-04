namespace TasksActivityModule.TasksActivityModule;

page 50261 "Document Purpose List"
{
    ApplicationArea = All;
    Caption = 'Document Purpose List';
    PageType = List;
    SourceTable = "Document Purpose";
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the code for the document purpose.';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the description for the document purpose.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Select)
            {
                ApplicationArea = All;
                Caption = 'Select';
                Image = SelectEntries;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                begin
                    CurrPage.Close();
                end;
            }
        }
    }
}