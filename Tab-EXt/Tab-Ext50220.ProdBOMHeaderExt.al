namespace TasksActivityModule.TasksActivityModule;

using Microsoft.Manufacturing.ProductionBOM;
using Microsoft.Projects.Project.Job;

tableextension 50220 "Prod BOM Header Ext" extends "Production BOM Header"
{
    fields
    {
        field(50200; "Project No."; Code[20])
        {
            Caption = 'Project No.';
            DataClassification = CustomerContent;
            TableRelation = Job;
        }
        
    }
}