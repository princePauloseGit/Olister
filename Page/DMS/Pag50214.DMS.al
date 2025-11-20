page 50214 "Doc Attachment History List"
{
    PageType = List;
    SourceTable = "Doc Attachment History";
    Caption = 'Document Management System';
    ApplicationArea = All;
    UsageCategory = Lists;
    InherentEntitlements = X;

    layout
    {
        area(Content)
        {
            // group(SearchGroup)
            // {
            //     Caption = 'Search';

            //     field(Search; DisplaySearchString)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Search';
            //         ToolTip = 'Type at least 2 characters and press Enter to search. Clear to reset.';

            //         trigger OnValidate()
            //         var
            //             Normalized: Text;
            //             Codeu: Codeunit "Data Search in Table";
            //         begin
            //             Codeu.FindInTable(Database::"Doc Attachment History",
            //             TableType,
            //             DisplaySearchString,
            //             Results);
            //             CurrPage.LinesPart.Page.
            //             // Normalized := DelChr(DisplaySearchString, '<>', ' ');
            //             // Normalized := DelChr(Normalized, '<>', ' ');
            //             // DisplaySearchString := Normalized;

            //             // if StrLen(Normalized) < 2 then begin
            //             //     ClearSearch();
            //             //     exit;
            //             // end;

            //             // ApplySearch(Normalized);
            //         end;
            //     }
            //     part(LinesPart; "Data Search lines")
            //     {
            //         ApplicationArea = All;
            //         UpdatePropagation = Both;
            //     }
            // }

            repeater(Group)
            {
                field("File Name"; Rec."File Name")
                {
                    ApplicationArea = All;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        RecDocAttachment: Record "Document Attachment";
                    begin
                        RecDocAttachment.Get(Rec."Table ID", Rec."Document No.", Rec."Document Type", Rec."Line No.", Rec.ID);
                        if DMSCodeunit.SupportedByFileViewer(RecDocAttachment) then
                            DMSCodeunit.ViewFile(RecDocAttachment, Rec)
                        else
                            DMSCodeunit.Export(true, RecDocAttachment);
                    end;
                }

                field("Source File"; tableName) { ApplicationArea = All; }
                field("Related No."; Rec."Document No.") { ApplicationArea = All; }
                field("Document Purpose"; Rec."Document Purpose") { ApplicationArea = All; }
                field("Document Tag"; Rec."Document Tag") { ApplicationArea = All; }
                field("User ID"; Rec."User ID") { ApplicationArea = All; }
                field("Date and Time"; Rec."Date and Time") { ApplicationArea = All; }
            }
        }
    }

    // actions
    // {
    //     area(Processing)
    //     {
    //         action(ClearSearchAction)
    //         {
    //             ApplicationArea = All;
    //             Caption = 'Clear Search';
    //             Image = ClearFilter;
    //             ToolTip = 'Clear the search and restore all records.';
    //             trigger OnAction()
    //             begin
    //                 DisplaySearchString := '';
    //                 ClearSearch();
    //             end;
    //         }
    //     }
    // }

    // trigger OnOpenPage()
    // begin
    //     PreSearchView := Rec.GetView();
    //     IsSearching := false;
    // end;

    trigger OnAfterGetRecord()
    var
        O: Record AllObjWithCaption;
    begin
        if O.Get(ObjectType::Table, Rec."Table ID") then
            tableName := O."Object Caption";
    end;

    // local procedure ApplySearch(SearchText: Text)
    // var
    //     R: Record "Doc Attachment History";
    //     Pattern: Text;
    // begin
    //     if not IsSearching then
    //         PreSearchView := Rec.GetView();

    //     Pattern := '@*' + SearchText + '*';


    //     Rec.MarkedOnly(false);
    //     Rec.ClearMarks();


    //     R.SetView(PreSearchView);
    //     R.SetLoadFields("File Name");
    //     R.SetFilter("File Name", Pattern);
    //     if R.FindSet() then
    //         repeat
    //             R.Mark(true);
    //         until R.Next() = 0;

    //     R.SetView(PreSearchView);
    //     R.SetLoadFields("Document No.");
    //     R.SetFilter("Document No.", Pattern);
    //     if R.FindSet() then
    //         repeat
    //             R.Mark(true);
    //         until R.Next() = 0;

    //     R.SetView(PreSearchView);
    //     R.SetLoadFields("Document Purpose");
    //     R.SetFilter("Document Purpose", Pattern);
    //     if R.FindSet() then
    //         repeat
    //             R.Mark(true);
    //         until R.Next() = 0;

    //     R.SetView(PreSearchView);
    //     R.SetLoadFields("Document Tag");
    //     R.SetFilter("Document Tag", Pattern);
    //     if R.FindSet() then
    //         repeat
    //             R.Mark(true);
    //         until R.Next() = 0;


    //     Rec.SetView(PreSearchView);
    //     Rec.MarkedOnly(true);
    //     IsSearching := true;

    //     CurrPage.Update(false);
    // end;

    // local procedure ClearSearch()
    // begin

    //     Rec.MarkedOnly(false);
    //     Rec.ClearMarks();

    //     Rec.SetView(PreSearchView);
    //     IsSearching := false;

    //     CurrPage.Update(false);
    // end;

    // local procedure ClearAllFilters()
    // begin
    //     Rec.SetRange("File Name");
    //     Rec.SetRange("Document No.");
    //     Rec.SetRange("Document Purpose");
    //     Rec.SetRange("Document Tag");
    //     Rec.SetRange("User ID");
    // end;

    var
        DMSCodeunit: Codeunit "DocAttach Ask Metadata";
        tableName: Text;

        DisplaySearchString: Text;
        PreSearchView: Text;
        IsSearching: Boolean;
        TableNo: Integer;
        TableType: Integer;
        SearchString: Text;
        Results: Dictionary of [Text, Text];

    // protected procedure AddResults(TableTypeId: Integer; var Results: Dictionary of [Text, Text])
    // begin
    //     CurrPage.LinesPart.Page.AddResults(TableTypeID, Results);
    // end;
}
