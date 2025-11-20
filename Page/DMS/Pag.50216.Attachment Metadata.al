page 50216 "Attachment Metadata Card"
{
    PageType = Card;
    SourceTable = "Doc Attachment History";
    Caption = 'Enter Document Purpose & Tag';
    InsertAllowed = false;
    DataCaptionExpression = Rec."Document No.";
    DeleteAllowed = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Document Purpose"; Rec."Document Purpose")
                {
                    ApplicationArea = All;
                }
                field("Document Tag"; Rec."Document Tag")
                {
                    ApplicationArea = All;
                    Editable = False;
                    AssistEdit = true;
                    trigger OnAssistEdit()
                    var
                        TagMaster: Record TagMaster;
                        TagPage: Page Tag;
                    begin
                        if Page.RunModal(Page::Tag, TagMaster) = Action::LookupOK then begin
                            Rec."Document Tag" := TagMaster.Tag;
                        end;
                    end;
                }
            }
        }
    }

}