namespace TasksActivityModule.TasksActivityModule;

using Microsoft.Projects.Project.Job;
using Microsoft.Foundation.NoSeries;
using Microsoft.Inventory.Setup;
using Microsoft.Inventory.Item.Attribute;
using Microsoft.Inventory.Item.Picture;
using Microsoft.Inventory.Item;
using System.Environment;
using System.Utilities;

page 50218 "Projects ListPart factbox"
{
    ApplicationArea = All;
    Caption = 'Projects List';

    PageType = ListPart;
    SourceTable = "Enquiry Lines";

    AutoSplitKey = true;
    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Creation Date"; Rec."Creation Date")
                { Caption = 'Date'; }
                field(Quantity; Rec.Quantity)
                { }

                field("Project Name"; Rec."Project Name")
                {
                    trigger OnDrillDown()
                    begin
                        OpenProjectCard();
                    end;
                }
                field(DocImage; MediaRec.Content)
                {
                    Caption = 'Picture';
                    ApplicationArea = all;
                    Editable = false;
                }


                field("No."; Rec."Project No")
                {
                    Editable = false;
                    ToolTip = 'Specifies the number of the involved entry or record, according to the specified number series.';
                    trigger OnDrillDown()
                    begin
                        OpenProjectCard();
                    end;
                }
                field(Owner; Rec.Owner) { }
                field(Status; Rec.Status)
                { }
                field("Review Date"; Rec."Review Date")
                { }



            }
        }
    }
    actions
    {
        area(Processing)
        {
            group(Line)
            {

                group(Project)
                {
                    action(CreateProductAndProject)
                    {
                        Caption = 'Create a Project with Product';
                        ApplicationArea = all;
                        Image = CreateDocument;
                        Enabled = AllowCreateProject;
                        Scope = Repeater;


                        trigger OnAction()
                        var
                            ProductPage: Page "New Product Card";
                            Enquiry: Record Enquiry;
                            TempItem: Record Item temporary;
                        begin
                            if Enquiry.Get(Rec."Enquiry No") then begin
                                TempItem.Init();
                                TempItem."No." := 'Item';
                                TempItem.Insert();
                                ProductPage.SetTempItemData(TempItem, Rec."Enquiry No");
                                if ProductPage.RunModal() = Action::OK then begin
                                    ProductPage.GetData(Rec."Item No", Rec."Project No");
                                end;
                            end;

                        end;
                    }
                    action(CreateProject)
                    {
                        Caption = 'Create a Project';
                        ApplicationArea = all;
                        Image = Job;
                        Enabled = AllowCreateProject;
                        Scope = Repeater;


                        trigger OnAction()
                        var
                            Enquiry: Record Enquiry;
                            Project: Record Job;
                        begin
                            if Enquiry.Get(Rec."Enquiry No") then begin
                                Project.Init();
                                Project.Validate("No.");
                                Project.Validate("Bill-to Customer No.", Enquiry."Customer No.");
                                Project.Validate("Enquiry No", Enquiry."Enquiry No.");
                                Project.Validate(Description, Rec.Description);
                                Project.Insert(true);
                                Rec.Validate("Project No", Project."No.");
                                Page.Run(Page::"Job Card", Project);
                            end;
                        end;


                    }
                }
            }
        }


    }
    var
        AllowCreateProject: Boolean;
        Project: Record Job;
        MediaRec: Record "Tenant Media";
        Item: Record Item;

    procedure OpenProjectCard()
    var
        Project: Record Job;
    begin
        if Project.Get(Rec."Project No") then begin
            Page.Run(Page::"Job Card", Project);
        end;
    end;

    trigger OnAfterGetCurrRecord()
    begin
        if Rec."Project No" <> '' then
            AllowCreateProject := false
        else begin
            AllowCreateProject := true;
            Clear(MediaRec);
        end;
    end;

    trigger OnAfterGetRecord()
    begin
        if Rec."Project No" <> '' then begin
            if Rec."Item No" <> '' then begin
                Item.Get(Rec."Item No");
                if Item.Picture.Count > 0 then begin
                    MediaRec.Get(Item.Picture.Item(1));
                    MediaRec.CalcFields(Content);
                end else
                    Clear(MediaRec);
            end else begin
                Project.Get(Rec."Project No");
                if Project.Picture.Count > 0 then begin
                    MediaRec.Get(Project.Picture.Item(1));
                    MediaRec.CalcFields(Content);

                end else
                    Clear(MediaRec);
            end;
        end else
            Clear(MediaRec);
    end;
}
