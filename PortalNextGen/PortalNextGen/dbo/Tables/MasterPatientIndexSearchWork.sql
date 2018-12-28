CREATE TABLE [dbo].[MasterPatientIndexSearchWork] (
    [MasterPatientIndexSearchWorkID] INT           IDENTITY (1, 1) NOT NULL,
    [Spid]                           INT           NULL,
    [PersonID]                       INT           NULL,
    [CreatedDateTime]                DATETIME2 (7) CONSTRAINT [DF_MasterPatientIndexSearchWork_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MasterPatientIndexSearchWork_MasterPatientIndexSearchWorkID] PRIMARY KEY CLUSTERED ([MasterPatientIndexSearchWorkID] ASC)
);

