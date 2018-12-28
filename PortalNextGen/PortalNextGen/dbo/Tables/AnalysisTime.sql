CREATE TABLE [dbo].[AnalysisTime] (
    [AnalysisTimeID]  INT           IDENTITY (1, 1) NOT NULL,
    [UserID]          INT           NOT NULL,
    [PatientID]       INT           NOT NULL,
    [StartDateTime]   DATETIME2 (7) NOT NULL,
    [EndDateTime]     DATETIME2 (7) NULL,
    [AnalysisType]    INT           NOT NULL,
    [InsertDateTime]  DATETIME2 (7) CONSTRAINT [DF_AnalysisTime_InsertedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_AnalysisTime_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_AnalysisTime_AnalysisTimeID] PRIMARY KEY CLUSTERED ([AnalysisTimeID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [FK_AnalysisTime_User_UserID]
    ON [dbo].[AnalysisTime]([UserID] ASC);

