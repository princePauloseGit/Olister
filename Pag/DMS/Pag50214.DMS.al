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
            group(SearchGroup)
            {
                Caption = 'Search & Filter';

                field(SearchText; SearchString)
                {
                    ApplicationArea = All;
                    Caption = 'Search Text';
                    ToolTip = 'Enter text to search in activity titles, file names, document purposes, and tags. Press Enter to search.';

                    trigger OnValidate()
                    begin
                        ApplySearch();
                    end;
                }

                field(FileNameFilter; FileNameFilterText)
                {
                    ApplicationArea = All;
                    Caption = 'File Name Filter';
                    ToolTip = 'Filter by file name';

                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;
                }

                field(DocumentPurposeFilter; DocumentPurposeFilterText)
                {
                    ApplicationArea = All;
                    Caption = 'Document Purpose Filter';
                    ToolTip = 'Filter by document purpose';
                    TableRelation = "Document Purpose";

                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;
                }

                field(ActivityTypeFilter; ActivityTypeFilterText)
                {
                    ApplicationArea = All;
                    Caption = 'Activity Type Filter';
                    ToolTip = 'Filter by activity type';
                    TableRelation = "Activity Type";

                    trigger OnValidate()
                    begin
                        ApplyFilters();
                    end;
                }
            }

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
                field("Document Purpose Description"; Rec."Document Purpose Description")
                {
                    ApplicationArea = All;
                    Caption = 'Purpose Description';
                }
                field("Document Tag"; Rec."Document Tag") { ApplicationArea = All; }
                field("Activity Title"; Rec."Activity Title") { ApplicationArea = All; }
                field("Activity Type"; Rec."Activity Type") { ApplicationArea = All; }
                field("Activity Project No."; Rec."Activity Project No.") { ApplicationArea = All; }
                field("Activity Enquiry No."; Rec."Activity Enquiry No.") { ApplicationArea = All; }
                field("User ID"; Rec."User ID") { ApplicationArea = All; }
                field("Date and Time"; Rec."Date and Time") { ApplicationArea = All; }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ClearFilters)
            {
                ApplicationArea = All;
                Caption = 'Clear All Filters';
                Image = ClearFilter;
                ToolTip = 'Clear all search and filter criteria.';

                trigger OnAction()
                begin
                    ClearAllSearchFilters();
                end;
            }

            action(AdvancedSearch)
            {
                ApplicationArea = All;
                Caption = 'Advanced Search';
                Image = Find;
                ToolTip = 'Open advanced search dialog.';

                trigger OnAction()
                begin
                    RunAdvancedSearch();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        // Only initialize on first load, not on every page refresh
        if not PageInitialized then begin
            OriginalView := Rec.GetView();
            IsSearchActive := false;
            PageInitialized := true;
        end;
    end;

    trigger OnAfterGetRecord()
    var
        O: Record AllObjWithCaption;
    begin
        if O.Get(ObjectType::Table, Rec."Table ID") then
            tableName := O."Object Caption";
    end;

    local procedure ApplySearch()
    begin
        if SearchString = '' then begin
            ClearSearch();
            exit;
        end;

        Rec.Reset();
        Rec.MarkedOnly(false);
        Rec.ClearMarks();

        if Rec.FindSet() then begin
            repeat
                if (StrPos(UpperCase(Rec."Activity Title"), UpperCase(SearchString)) > 0) or
                   (StrPos(UpperCase(Rec."Document Purpose"), UpperCase(SearchString)) > 0) or
                   (StrPos(UpperCase(Rec."Document Purpose Description"), UpperCase(SearchString)) > 0) or
                   (StrPos(UpperCase(Rec."Document Tag"), UpperCase(SearchString)) > 0) or
                   (StrPos(UpperCase(Rec."Activity Tags"), UpperCase(SearchString)) > 0) or
                   (StrPos(UpperCase(Rec."Activity Type"), UpperCase(SearchString)) > 0) or
                   (StrPos(UpperCase(Rec."Activity Project No."), UpperCase(SearchString)) > 0) or
                   (StrPos(UpperCase(Rec."Activity Enquiry No."), UpperCase(SearchString)) > 0) then begin

                    Rec.Mark(true);
                end;
            until Rec.Next() = 0;
        end;

        Rec.MarkedOnly(true);
        IsSearchActive := true;

        if Rec.FindFirst() then;

        CurrPage.Update(false);
    end;

    local procedure ApplyFilters()
    begin
        if (FileNameFilterText = '') and (DocumentPurposeFilterText = '') and (ActivityTypeFilterText = '') then begin
            Rec.Reset();
            Rec.MarkedOnly(false);
            Rec.ClearMarks();
            IsSearchActive := false;

            if Rec.FindFirst() then;

            CurrPage.Update(false);
            exit;
        end;

        Rec.Reset();
        Rec.MarkedOnly(false);
        Rec.ClearMarks();

        if FileNameFilterText <> '' then begin
            Rec.CalcFields("File Name");
            Rec.SetFilter("File Name", '*' + FileNameFilterText + '*');
        end;

        if DocumentPurposeFilterText <> '' then
            Rec.SetFilter("Document Purpose", DocumentPurposeFilterText);

        if ActivityTypeFilterText <> '' then
            Rec.SetFilter("Activity Type", ActivityTypeFilterText);

        if Rec.FindFirst() then;

        CurrPage.Update(false);
    end;

    local procedure ClearSearch()
    begin
        Rec.MarkedOnly(false);
        Rec.ClearMarks();
        Rec.Reset();
        IsSearchActive := false;

        if Rec.FindFirst() then;

        CurrPage.Update(false);
    end;

    local procedure ClearAllSearchFilters()
    begin
        SearchString := '';
        FileNameFilterText := '';
        DocumentPurposeFilterText := '';
        ActivityTypeFilterText := '';

        ClearSearch();
        Rec.Reset();
    end;

    local procedure RunAdvancedSearch()
    var
        AdvancedSearchPage: Page "Doc Attachment Advanced Search";
    begin
        if AdvancedSearchPage.RunModal() = Action::OK then begin
            AdvancedSearchPage.ApplyFiltersToRecord(Rec);
        end;
    end;

    var
        DMSCodeunit: Codeunit "DocAttach Ask Metadata";
        tableName: Text;
        SearchString: Text;
        FileNameFilterText: Text;
        DocumentPurposeFilterText: Code[20];
        ActivityTypeFilterText: Code[20];
        OriginalView: Text;
        IsSearchActive: Boolean;
        PageInitialized: Boolean;
}