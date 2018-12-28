CREATE TABLE [dbo].[PrintJobEnhancedTelemetryVital] (
    [PrintJobEnhancedTelemetryVitalID] INT            NOT NULL,
    [PatientID]                        INT            NOT NULL,
    [TopicSessionID]                   INT            NOT NULL,
    [GlobalDataSystemCode]             VARCHAR (80)   NOT NULL,
    [Name]                             NVARCHAR (255) NOT NULL,
    [Value]                            NVARCHAR (255) NOT NULL,
    [ResultDateTime]                   DATETIME2 (7)  NOT NULL,
    [CreatedDateTime]                  DATETIME2 (7)  CONSTRAINT [DF_PrintJobEnhancedTelemetryVital_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PrintJobEnhancedTelemetryVital_PrintJobEnhancedTelemetryVitalID] PRIMARY KEY CLUSTERED ([PrintJobEnhancedTelemetryVitalID] ASC),
    CONSTRAINT [FK_PrintJobEnhancedTelemetryVital_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID]),
    CONSTRAINT [FK_PrintJobEnhancedTelemetryVital_TopicSession_TopicSessionID] FOREIGN KEY ([TopicSessionID]) REFERENCES [dbo].[TopicSession] ([TopicSessionID])
);


GO
CREATE NONCLUSTERED INDEX [IX_PrintJobEnhancedTelemetryVital_PatientID_TopicSessionID_GlobalDataSystemCode_Name_Value_ResultTime]
    ON [dbo].[PrintJobEnhancedTelemetryVital]([PatientID] ASC, [TopicSessionID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PrintJobEnhancedTelemetryVital_Patient_PatientID]
    ON [dbo].[PrintJobEnhancedTelemetryVital]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_PrintJobEnhancedTelemetryVital_TopicSession_TopicSessionID]
    ON [dbo].[PrintJobEnhancedTelemetryVital]([TopicSessionID] ASC);

