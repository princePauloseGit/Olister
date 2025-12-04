namespace ChilternGlobalBC.ChilternGlobalBC;

using Microsoft.Inventory.Item;
using TasksActivityModule.TasksActivityModule;
using Microsoft.Projects.Project.Job;

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
                    DrillDownPageId = "Job List";

                }
                field("Live Projects"; Rec."Live Projects")
                {
                    ToolTip = 'Specifies the value of the Live Projects field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    DrillDownPageId = "Job List";
                }
                field("All Enquiries"; AllEnquiries)
                {
                    ToolTip = 'Specifies the value of the All Enquiries field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    DrillDownPageId = "Enquiries";
                    trigger OnDrillDown()
                    begin

                        Page.Run(Page::Enquiries, AllEnquiryRec);
                    end;
                }
                field("Live Enquiries"; LiveEnquiries)
                {
                    ToolTip = 'Specifies the value of the Live Enquiries field.', Comment = '%';
                    ApplicationArea = Basic, Suite;
                    Editable = false;
                    DrillDownPageId = "Enquiries";
                    trigger OnDrillDown()
                    begin
                        Page.Run(Page::Enquiries, LiveEnquiryRec);
                    end;
                }
            }
        }
    }
    var
        LiveEnquiries, AllEnquiries : Integer;
        AllEnquiryRec: Record Enquiry;
        LiveEnquiryRec: Record Enquiry;
        EnqFilter: Text;


    trigger OnAfterGetRecord()
    var

        Project: Record Job;
        EnqNo: Code[20];
        EnquiryNos: List of [Code[20]];

    begin
        ClearAll();
        // find all projects linked to this item
        Project.SetRange("Item No", Rec."No.");
        if Project.FindSet() then
            repeat
                if (Project."Enquiry No" <> '') AND (not EnquiryNos.Contains(Project."Enquiry No")) then begin
                    EnquiryNos.Add(Project."Enquiry No");
                    if EnqFilter = '' then
                        EnqFilter := Project."Enquiry No"
                    else
                        EnqFilter := EnqFilter + '|' + Project."Enquiry No";
                end;
            until Project.Next() = 0;


        AllEnquiryRec.SetFilter("Enquiry No.", '%1', EnqFilter);
        if AllEnquiryRec.FindSet() then begin
            AllEnquiries := AllEnquiryRec.Count;
        end;

        LiveEnquiryRec.SetFilter("Enquiry No.", '%1', EnqFilter);
        LiveEnquiryRec.SetFilter(Status, '<>%1', LiveEnquiryRec.Status::Closed);
        if LiveEnquiryRec.FindSet() then begin
            LiveEnquiries := LiveEnquiryRec.Count;
        end;
    end;

}
