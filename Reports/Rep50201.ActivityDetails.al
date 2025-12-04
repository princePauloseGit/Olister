namespace ChilternGlobalBC.ChilternGlobalBC;

report 50201 "Activity Details"
{
    ApplicationArea = All;
    Caption = 'Activity Details';
    RDLCLayout = './Reports/ActivityDetails.rdl';
    UsageCategory = ReportsAndAnalysis;
    dataset
    {
        dataitem(AANActivity; AANActivity)
        {
            column(AccountableUserId; "Accountable UserId")
            {
            }
            column(AccountableUserId_lbl; AccountableUserId_lbl) { }
            column(AssignedToUserId; "Assigned To UserId")
            {
            }
            column(AssignedToUserId_lbl; AssignedToUserId_lbl) { }
            column(CustomerNo; "Customer No.")
            {
            }
            column(CustomerNo_lbl; CustomerNo_lbl) { }
            column(DueDate; "Due Date")
            {
            }
            column(DueDate_lbl; DueDate_lbl) { }
            column(EnquiryDueDate; "Enquiry Due Date")
            {
            }
            column(EnquiryDueDate_lbl; EnquiryDueDate_lbl) { }
            column(EnquiryName; "Enquiry Name")
            {
            }
            column(EnquiryName_lbl; EnquiryName_lbl) { }
            column(EnquiryNo; "Enquiry No.")
            {
            }
            column(EnquiryNo_lbl; EnquiryNo_lbl) { }
            column(EnquiryStartDate; "Enquiry Start Date")
            {
            }
            column(EnquiryStartDate_lbl; EnquiryStartDate_lbl) { }
            column(ItemNo; "Item No.")
            {
            }
            column(ItemNo_lbl; ItemNo_lbl) { }
            column(ProjectEndDate; "Project End Date")
            {
            }
            column(ProjectEndDate_lbl; ProjectEndDate_lbl) { }
            column(ProjectName; "Project Name")
            {
            }
            column(ProjectName_lbl; ProjectName_lbl) { }
            column(ProjectNo; "Project No.")
            {
            }
            column(ProjectNo_lbl; ProjectNo_lbl) { }
            column(ProjectPlanningLineNo; "Project Planning Line No")
            {
            }
            column(ProjectPlanningLineNo_lbl; ProjectPlanningLineNo_lbl) { }
            column(ProjectStartDate; "Project Start Date")
            {
            }
            column(ProjectStartDate_lbl; ProjectStartDate_lbl) { }
            column(ProjectTaskNo; "Project Task No.")
            {
            }
            column(ProjectTaskNo_lbl; ProjectTaskNo_lbl) { }
            column(Purchase; Purchase)
            {
            }
            column(Purchase_lbl; Purchase_lbl) { }
            column(PurchasePriceListcode; "Purchase Price List code")
            {
            }
            column(PurchasePriceListcode_lbl; PurchasePriceListcode_lbl) { }
            column(ReviewDate; "Review Date")
            {
            }
            column(ReviewDate_lbl; ReviewDate_lbl) { }
            column(Sale; Sale)
            {
            }
            column(Sale_lbl; Sale_lbl) { }
            column(SalesPriceListcode; "Sales Price List code")
            {
            }
            column(SystemCreatedAt; SystemCreatedAt)
            {
            }
            column(SystemCreatedBy; SystemCreatedBy)
            {
            }
            column(SystemId; SystemId)
            {
            }
            column(SystemModifiedAt; SystemModifiedAt)
            {
            }
            column(SystemModifiedBy; SystemModifiedBy)
            {
            }
            column(TableName; "Table Name")
            {
            }
            column(TableName_lbl; TableName_lbl) { }
            column(Tags; Tags)
            {
            }
            column(Tags_lbl; Tags_lbl) { }
            column(VendorNo; "Vendor No.")
            {
            }
            column(VendorNo_lbl; VendorNo_lbl) { }
            column(ActivityNo; "Activity No")
            {
            }
            column(ActivityNo_lbl; ActivityNo_lbl) { }
            column(ActivityTitle; "Activity Title")
            {
            }
            column(ActivityTitle_lbl; ActivityTitle_lbl) { }
            column(Activitytype; "Activity type")
            {
            }
            column(Activitytype_lbl; Activitytype_lbl) { }
            column(Status; Status)
            {
            }
            column(Status_lbl; Status_lbl) { }
            column(Description; Description)
            {
            }
            column(Description_lbl; Description_lbl) { }
            column(Accountable; Accountable)
            {
            }
            column(Accountable_lbl; Accountable_lbl) { }
            column(AccountableDate; "Accountable Date")
            {
            }
            column(AccountableDate_lbl; AccountableDate_lbl) { }
            column(AssignedTo; "Assigned To")
            {
            }
            column(AssignedTo_lbl; AssignedTo_lbl) { }
            column(AssignedDate; "Assigned Date")
            {
            }
            column(AssignedDate_lbl; AssignedDate_lbl) { }
            column(CreatedBy; "Created By")
            {
            }
            column(CompletedBy; "Completed By")
            {
            }
            column(CompletedBy_lbl; CompletedBy_lbl) { }
            column(CompletedDate; "Completed Date")
            {
            }
            column(CompletedDate_lbl; CompletedDate_lbl) { }
            column(RecordNo; "Record No.")
            {
            }
            column(RecordNo_lbl; RecordNo_lbl) { }
            column(RelatedIssueNo; "Related Issue No")
            {
            }
            column(RelatedIssueNo_lbl; RelatedIssueNo_lbl) { }
        }
    }
    var
        AccountableUserId_lbl: Label 'Accountable UserId';
        AssignedToUserId_lbl: Label 'Assigned To UserId';
        CustomerNo_lbl: Label 'Customer No.';
        DueDate_lbl: Label 'Due Date';
        EnquiryDueDate_lbl: Label 'Enquiry Due Date';
        EnquiryName_lbl: Label 'Enquiry Name';

        EnquiryNo_lbl: Label 'Enquiry No.';
        EnquiryStartDate_lbl: Label 'Enquiry Start Date';
        ItemNo_lbl: Label 'Item No.';
        ProjectEndDate_lbl: Label 'Project End Date';
        ProjectName_lbl: Label 'Project Name';
        ProjectNo_lbl: Label 'Project No.';
        ProjectPlanningLineNo_lbl: Label 'Project Planning Line No';
        ProjectStartDate_lbl: Label 'Project Start Date';
        ProjectTaskNo_lbl: Label 'Project Task No.';
        Purchase_lbl: Label 'Purchase';
        PurchasePriceListcode_lbl: Label 'Purchase Price List code';
        ReviewDate_lbl: Label 'Review Date';
        Sale_lbl: Label 'Sale';
        SalesPriceListcode_lbl: Label 'Sales Price List code';
        SystemCreatedAt_lbl: Label 'SystemCreatedAt';
        SystemCreatedBy_lbl: Label 'SystemCreatedBy';

        SystemId_lbl: Label 'SystemId';
        SystemModifiedAt_lbl: Label 'SystemModifiedAt';
        SystemModifiedBy_lbl: Label 'SystemModifiedBy';
        TableName_lbl: Label 'Table Name';
        Tags_lbl: Label 'Tags';
        VendorNo_lbl: Label 'Vendor No.';
        ActivityNo_lbl: Label 'Activity No';
        ActivityTitle_lbl: Label 'Activity Title';
        Activitytype_lbl: Label 'Activity type';
        Status_lbl: Label 'Status';
        Description_lbl: Label 'Description';
        Accountable_lbl: Label 'Accountable';

        AccountableDate_lbl: Label 'Accountable Date';
        AssignedTo_lbl: Label 'Assigned To';
        AssignedDate_lbl: Label 'Assigned Date';
        CreatedBy_lbl: Label 'Created By';
        CompletedBy_lbl: Label 'Completed By';
        CompletedDate_lbl: Label 'Completed Date';
        RecordNo_lbl: Label 'Record No.';
        RelatedIssueNo_lbl: Label 'Related Issue No';
}
