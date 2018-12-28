CREATE TABLE [dbo].[PatientSession] (
    [PatientSessionID] INT           IDENTITY (1, 1) NOT NULL,
    [BeginDateTime]    DATETIME2 (7) NOT NULL,
    [EndDateTime]      DATETIME2 (7) NULL,
    [CreatedDateTime]  DATETIME2 (7) CONSTRAINT [DF_PatientSession_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PatientSession_PatientSessionID] PRIMARY KEY CLUSTERED ([PatientSessionID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_PatientSessions_PatientSessionID_BeginDateTime_EndTime]
    ON [dbo].[PatientSession]([PatientSessionID] ASC);

