namespace TasksActivityModule.TasksActivityModule;

page 50263 "Doc Attachment Advanced Search"
{
    ApplicationArea = All;
    Caption = 'Advanced Search - Document Attachments';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            group(SearchCriteria)
            {
                Caption = 'Search Criteria';

                field(ActivityTitleSearch; ActivityTitleText)
                {
                    ApplicationArea = All;
                    Caption = 'Activity Title';
                    ToolTip = 'Search for activities containing this text in the title';
                }

                field(FileNameSearch; FileNameText)
                {
                    ApplicationArea = All;
                    Caption = 'File Name';
                    ToolTip = 'Search for files containing this text in the name';
                }

                field(DocumentPurposeSearch; DocumentPurposeCode)
                {
                    ApplicationArea = All;
                    Caption = 'Document Purpose';
                    ToolTip = 'Filter by specific document purpose';
                    TableRelation = "Document Purpose";
                }

                field(DocumentTagSearch; DocumentTagText)
                {
                    ApplicationArea = All;
                    Caption = 'Document Tag';
                    ToolTip = 'Search for documents with specific tags';
                }

                field(ActivityTypeSearch; ActivityTypeCode)
                {
                    ApplicationArea = All;
                    Caption = 'Activity Type';
                    ToolTip = 'Filter by activity type';
                    TableRelation = "Activity Type";
                }

                field(ProjectNoSearch; ProjectNoText)
                {
                    ApplicationArea = All;
                    Caption = 'Project No.';
                    ToolTip = 'Filter by project number';
                }

                field(EnquiryNoSearch; EnquiryNoText)
                {
                    ApplicationArea = All;
                    Caption = 'Enquiry No.';
                    ToolTip = 'Filter by enquiry number';
                }

                field(CreatedBySearch; CreatedByText)
                {
                    ApplicationArea = All;
                    Caption = 'Created By';
                    ToolTip = 'Filter by user who created the activity';
                }

                field(AssignedToSearch; AssignedToText)
                {
                    ApplicationArea = All;
                    Caption = 'Assigned To';
                    ToolTip = 'Filter by user assigned to the activity';
                }
            }

            group(DateRange)
            {
                Caption = 'Date Range';

                field(DateFromSearch; DateFrom)
                {
                    ApplicationArea = All;
                    Caption = 'Date From';
                    ToolTip = 'Filter documents from this date';
                }

                field(DateToSearch; DateTo)
                {
                    ApplicationArea = All;
                    Caption = 'Date To';
                    ToolTip = 'Filter documents to this date';
                }
            }

            group(ActivityStatus)
            {
                Caption = 'Activity Status';

                field(StatusOpenSearch; IncludeOpen)
                {
                    ApplicationArea = All;
                    Caption = 'Include Open';
                    ToolTip = 'Include activities with Open status';
                }

                field(StatusWIPSearch; IncludeWIP)
                {
                    ApplicationArea = All;
                    Caption = 'Include Work In Progress';
                    ToolTip = 'Include activities with Work In Progress status';
                }

                field(StatusClosedSearch; IncludeClosed)
                {
                    ApplicationArea = All;
                    Caption = 'Include Closed';
                    ToolTip = 'Include activities with Closed status';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Search)
            {
                ApplicationArea = All;
                Caption = 'Search';
                Image = Find;
                InFooterBar = true;

                trigger OnAction()
                begin
                    SearchCompleted := true;
                    CurrPage.Close();
                end;
            }

            action(Clear)
            {
                ApplicationArea = All;
                Caption = 'Clear All';
                Image = ClearFilter;
                InFooterBar = true;

                trigger OnAction()
                begin
                    ClearAllFields();
                end;
            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    begin
        if CloseAction = Action::OK then
            exit(SearchCompleted);
        exit(true);
    end;

    procedure ApplyFiltersToRecord(var DocAttachHistory: Record "Doc Attachment History")
    begin
        if not SearchCompleted then
            exit;

        DocAttachHistory.Reset();

        if ActivityTitleText <> '' then
            DocAttachHistory.SetFilter("Activity Title", '@*' + ActivityTitleText + '*');

        if FileNameText <> '' then begin
            DocAttachHistory.CalcFields("File Name");
            DocAttachHistory.SetFilter("File Name", '@*' + FileNameText + '*');
        end;

        if DocumentPurposeCode <> '' then
            DocAttachHistory.SetRange("Document Purpose", DocumentPurposeCode);

        if DocumentTagText <> '' then
            DocAttachHistory.SetFilter("Document Tag", '@*' + DocumentTagText + '*');

        if ActivityTypeCode <> '' then
            DocAttachHistory.SetRange("Activity Type", ActivityTypeCode);

        if ProjectNoText <> '' then
            DocAttachHistory.SetFilter("Activity Project No.", '@*' + ProjectNoText + '*');

        if EnquiryNoText <> '' then
            DocAttachHistory.SetFilter("Activity Enquiry No.", '@*' + EnquiryNoText + '*');

        if CreatedByText <> '' then
            DocAttachHistory.SetFilter("Activity Created By", '@*' + CreatedByText + '*');

        if AssignedToText <> '' then
            DocAttachHistory.SetFilter("Activity Assigned To", '@*' + AssignedToText + '*');

        if (DateFrom <> 0D) or (DateTo <> 0D) then
            DocAttachHistory.SetRange("Date and Time", CreateDateTime(DateFrom, 0T), CreateDateTime(DateTo, 235959T));

        // Apply status filters
        ApplyStatusFilters(DocAttachHistory);
    end;

    local procedure ApplyStatusFilters(var DocAttachHistory: Record "Doc Attachment History")
    var
        StatusFilter: Text;
    begin
        StatusFilter := '';

        if IncludeOpen then
            StatusFilter := '0'; // Open = 0

        if IncludeWIP then begin
            if StatusFilter <> '' then
                StatusFilter += '|1'
            else
                StatusFilter := '1'; // WIP = 1
        end;

        if IncludeClosed then begin
            if StatusFilter <> '' then
                StatusFilter += '|2'
            else
                StatusFilter := '2'; // Closed = 2
        end;

        if StatusFilter <> '' then
            DocAttachHistory.SetFilter("Activity Status", StatusFilter);
    end;

    local procedure ClearAllFields()
    begin
        ActivityTitleText := '';
        FileNameText := '';
        DocumentPurposeCode := '';
        DocumentTagText := '';
        ActivityTypeCode := '';
        ProjectNoText := '';
        EnquiryNoText := '';
        CreatedByText := '';
        AssignedToText := '';
        DateFrom := 0D;
        DateTo := 0D;
        IncludeOpen := true;
        IncludeWIP := true;
        IncludeClosed := true;
        SearchCompleted := false;
    end;

    trigger OnOpenPage()
    begin
        // Set default values
        IncludeOpen := true;
        IncludeWIP := true;
        IncludeClosed := true;
        SearchCompleted := false;
    end;

    var
        ActivityTitleText: Text;
        FileNameText: Text;
        DocumentPurposeCode: Code[20];
        DocumentTagText: Text;
        ActivityTypeCode: Code[20];
        ProjectNoText: Text;
        EnquiryNoText: Text;
        CreatedByText: Text;
        AssignedToText: Text;
        DateFrom: Date;
        DateTo: Date;
        IncludeOpen: Boolean;
        IncludeWIP: Boolean;
        IncludeClosed: Boolean;
        SearchCompleted: Boolean;
}