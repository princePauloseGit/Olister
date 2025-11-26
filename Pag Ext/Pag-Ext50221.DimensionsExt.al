namespace TasksActivityModule.TasksActivityModule;

using Microsoft.Finance.Dimension;

pageextension 50221 "Dimensions Ext" extends Dimensions
{
    actions
    {
        addafter("&Dimension")
        {
            action(SyncProjectDimensions)
            {
                Caption = 'Sync Project Dimensions';
                ApplicationArea = all;
                Image = Refresh;
                ToolTip = 'Synchronize all existing projects with dimensions. This will create dimension values for projects that are not yet added to dimensions.';

                trigger OnAction()
                var
                    ProjectDimensionMgt: Codeunit "Project Dimension Management";
                begin
                    if Confirm('This will create dimension values for all existing projects that are not yet in dimensions. Do you want to continue?') then
                        ProjectDimensionMgt.SyncAllProjects();
                end;
            }
        }
    }
}