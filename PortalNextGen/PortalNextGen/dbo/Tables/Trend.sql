CREATE TABLE [dbo].[Trend] (
    [UserID]           INT             NOT NULL,
    [PatientID]        INT             NOT NULL,
    [TotalCategories]  INT             NOT NULL,
    [StartDateTime]    INT             NOT NULL,
    [TotalPeriods]     INT             NOT NULL,
    [SamplesPerPeriod] INT             NOT NULL,
    [TrendData]        VARBINARY (MAX) NULL,
    [AnalysisTimeID]   INT             NOT NULL,
    [CreatedDateTime]  DATETIME2 (7)   CONSTRAINT [DF_Trend_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Trend_UserID_PatientID] PRIMARY KEY CLUSTERED ([UserID] ASC, [PatientID] ASC),
    CONSTRAINT [FK_Trend_AnalysisTime_AnalysisTimeID] FOREIGN KEY ([AnalysisTimeID]) REFERENCES [dbo].[AnalysisTime] ([AnalysisTimeID]),
    CONSTRAINT [FK_Trend_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [FK_Trend_AnalysisTime_AnalysisTimeID]
    ON [dbo].[Trend]([AnalysisTimeID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Trend_Patient_PatientID]
    ON [dbo].[Trend]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_Trend_User_UserID]
    ON [dbo].[Trend]([UserID] ASC);

