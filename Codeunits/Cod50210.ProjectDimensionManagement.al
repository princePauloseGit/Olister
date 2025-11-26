namespace TasksActivityModule.TasksActivityModule;

using Microsoft.Finance.Dimension;
using Microsoft.Projects.Project.Job;

codeunit 50210 "Project Dimension Management"
{
    trigger OnRun()
    var
        Job: Record Job;
    begin
        if Job.FindSet() then
            repeat
                CreateProjectDimensions(Job."No.");
            until Job.Next() = 0;
    end;

    procedure CreateProjectDimensions(ProjectNo: Code[20])
    var
        Dimension: Record Dimension;
        DimensionValue: Record "Dimension Value";
        DimCode: Code[20];
    begin
        DimCode := 'PROJECT';

        // Create or ensure Project dimension exists
        if not Dimension.Get(DimCode) then begin
            Dimension.Init();
            Dimension.Validate(Code, DimCode);
            Dimension.Validate(Name, 'Project');
            Dimension.Insert(true);
        end;

        // Create dimension value for the project
        if not DimensionValue.Get(DimCode, ProjectNo) then begin
            DimensionValue.Init();
            DimensionValue.Validate("Dimension Code", DimCode);
            DimensionValue.Validate(Code, ProjectNo);
            DimensionValue.Validate(Name, GetProjectName(ProjectNo));
            DimensionValue.Insert(true);
        end;
    end;

    procedure SyncAllProjects()
    var
        Job: Record Job;
    begin
        if Job.FindSet() then
            repeat
                CreateProjectDimensions(Job."No.");
            until Job.Next() = 0;

        Message('All projects have been synchronized with dimensions.');
    end;

    local procedure GetProjectName(ProjectNo: Code[20]): Text[50]
    var
        Job: Record Job;
    begin
        if Job.Get(ProjectNo) then
            exit(CopyStr(Job.Description, 1, 50));
        exit(ProjectNo);
    end;
}