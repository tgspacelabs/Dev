CREATE TABLE [dbo].[TemplateSetInformation] (
    [TemplateSetInformationID] INT           IDENTITY (1, 1) NOT NULL,
    [UserID]                   INT           NOT NULL,
    [PatientID]                INT           NOT NULL,
    [TemplateSetIndex]         INT           NOT NULL,
    [lead_one]                 INT           NOT NULL,
    [lead_two]                 INT           NOT NULL,
    [number_of_bins]           INT           NOT NULL,
    [number_of_templates]      INT           NOT NULL,
    [AnalysisTimeID]           INT           NOT NULL,
    [CreatedDateTime]          DATETIME2 (7) CONSTRAINT [DF_TemplateSetInformation_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_TemplateSetInformation_TemplateSetInformationID] PRIMARY KEY CLUSTERED ([TemplateSetInformationID] ASC),
    CONSTRAINT [FK_TemplateSetInformation_AnalysisTime_AnalysisTimeID] FOREIGN KEY ([AnalysisTimeID]) REFERENCES [dbo].[AnalysisTime] ([AnalysisTimeID]),
    CONSTRAINT [FK_TemplateSetInformation_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [IX_TemplateSetInformation_UserID_PatientID_TemplateSetIndex]
    ON [dbo].[TemplateSetInformation]([UserID] ASC, [PatientID] ASC, [TemplateSetIndex] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_TemplateSetInformation_AnalysisTime_AnalysisTimeID]
    ON [dbo].[TemplateSetInformation]([AnalysisTimeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_TemplateSetInformation_Patient_PatientID]
    ON [dbo].[TemplateSetInformation]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_TemplateSetInformation_User_UserID]
    ON [dbo].[TemplateSetInformation]([UserID] ASC);

