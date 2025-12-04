page 50220 "Doc Attachment Card"
{
    PageType = Card;
    // SourceTable = "Doc Attachment History";
    Caption = 'Attach Document';
    ApplicationArea = All;
    UsageCategory = Lists;
    InsertAllowed = false;
    // DataCaptionFields = "Document No.";
    // DataCaptionExpression = Rec."Document No.";

    layout
    {
        area(content)
        {
            group("Document Details")
            {

                field("Document Purpose"; p)
                {
                    ApplicationArea = All;

                }
                field("Document Tag"; t)
                {
                    ApplicationArea = All;
                    AssistEdit = true;
                    Editable = false;
                    trigger OnAssistEdit()

                    var
                        TagMaster: Record TagMaster;
                        TagsText: Text;
                    begin
                        if Page1.RunModal() = Action::OK then begin

                            Page1.SetSelectionFilter(TagMaster);
                            if TagMaster.FindSet() then begin
                                repeat
                                    if TagsText = '' then
                                        TagsText := TagMaster.Tag
                                    else
                                        TagsText := TagsText + ',' + TagMaster.Tag;
                                until TagMaster.Next() = 0;
                                t := TagsText;
                                Clear(Page1);
                            end;
                        end;
                    end;
                }
            }

        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        myInt: Integer;
    begin


        if CloseAction = Action::OK then begin
            repeat
                DocAttac.Validate("Document Purpose", P);
                DocAttac.Validate("Document Tag", t);
                DocAttac.Modify(true)
            until DocAttac.Next() = 0;

        end;

    end;

    procedure getdata(var g: Record "Doc Attachment History")
    begin
        DocAttac := g;
        // repeat
        //     Message('getdata %1', g."Entry No.");
        // until g.Next() = 0;
    end;

    var
        Page1: Page tag;
        t: Text;
        P: Text;
        DocAttac: Record "Doc Attachment History";
}