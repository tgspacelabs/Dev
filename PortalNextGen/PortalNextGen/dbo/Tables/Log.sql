CREATE TABLE [dbo].[Log] (
    [LogID]            BIGINT         IDENTITY (0, 1) NOT NULL,
    [DateTime]         DATETIME2 (7)  NOT NULL,
    [PatientID]        INT            NOT NULL,
    [Application]      NVARCHAR (256) NOT NULL,
    [DeviceName]       NVARCHAR (256) NOT NULL,
    [Message]          NVARCHAR (MAX) NOT NULL,
    [LocalizedMessage] NVARCHAR (MAX) NOT NULL,
    [MessageID]        INT            NOT NULL,
    [LogType]          NVARCHAR (64)  NOT NULL,
    [CreatedDateTime]  DATETIME2 (7)  CONSTRAINT [DF_Log_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Log_LogID] PRIMARY KEY CLUSTERED ([LogID] ASC),
    CONSTRAINT [FK_Log_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [FK_Log_Patient_PatientID]
    ON [dbo].[Log]([PatientID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Purger_Log_CreatedDateTime_LogID]
    ON [dbo].[Log]([CreatedDateTime] ASC, [LogID] ASC);

