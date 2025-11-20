namespace ALProject.ALProject;
using TasksActivityModule.TasksActivityModule;

page 50246 "Issue Register Activity"
{
    ApplicationArea = All;
    Caption = 'Issue Register Activity';
    PageType = CardPart;
    SourceTable = "Issue Register";

    layout
    {
        area(Content)
        {
            cuegroup(Issues)
            {
                field(IssuesOpen; IssuesOpen)
                {
                    ToolTip = 'View Issues Open List';
                    Caption = 'Issues Open';
                    trigger OnDrillDown()
                    var
                        IssueRegister: Record "Issue Register";
                        IssuesList: Page "Issues List";
                    begin
                        IssueRegister.SetFilter(Status, '%1', IssueRegister.Status::Open);
                        IssuesList.SetTableView(IssueRegister);
                        IssuesList.Run();
                    end;
                }

                field(IssuesForUser; IssuesForUser)
                {
                    ToolTip = 'View Issues for Current User';
                    Caption = 'Issues for User';
                    trigger OnDrillDown()
                    var
                        IssueRegister: Record "Issue Register";
                        IssuesList: Page "Issues List";
                    begin
                        IssueRegister.SetFilter("Issue Owner", UserId);
                        IssuesList.SetTableView(IssueRegister);
                        IssuesList.Run();
                    end;
                }

                field(IssuesAll; IssuesAll)
                {
                    ToolTip = 'View All Issues List';
                    Caption = 'Issues All';
                    trigger OnDrillDown()
                    var
                        IssueRegister: Record "Issue Register";
                        IssuesList: Page "Issues List";
                    begin
                        IssuesList.SetTableView(IssueRegister);
                        IssuesList.Run();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        IssueRegister: Record "Issue Register";
        IssueRegister1: Record "Issue Register";
        IssueRegister2: Record "Issue Register";
    begin
        IssueRegister.Reset();
        IssueRegister.SetFilter(Status, '%1', IssueRegister.Status::Open);
        IssuesOpen := IssueRegister.Count();

        IssueRegister1.Reset();
        IssueRegister1.SetFilter("Issue Owner", UserId);
        IssuesForUser := IssueRegister1.Count();

        IssueRegister2.Reset();
        IssuesAll := IssueRegister2.Count();
    end;

    var
        IssuesOpen: Integer;
        IssuesForUser: Integer;
        IssuesAll: Integer;
}