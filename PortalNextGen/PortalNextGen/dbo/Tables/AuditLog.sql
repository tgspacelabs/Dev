CREATE TABLE [dbo].[AuditLog] (
    [AuditLogID]        INT            IDENTITY (1, 1) NOT NULL,
    [LoginID]           INT            NULL,
    [ApplicationID]     INT            NULL,
    [PatientID]         INT            NULL,
    [OriginalPatientID] INT            NULL,
    [AuditType]         NVARCHAR (160) NULL,
    [DeviceName]        NVARCHAR (64)  NULL,
    [AuditDescription]  NVARCHAR (500) NULL,
    [AuditDateTime]     DATETIME2 (7)  NOT NULL,
    [EncounterID]       INT            NULL,
    [DetailID]          INT            NULL,
    [CreatedDateTime]   DATETIME2 (7)  CONSTRAINT [DF_AuditLog_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Intesys_AuditLog_AuditLogID] PRIMARY KEY CLUSTERED ([AuditLogID] ASC),
    CONSTRAINT [FK_AuditLog_Patient_PatientID] FOREIGN KEY ([PatientID]) REFERENCES [dbo].[Patient] ([PatientID])
);


GO
CREATE NONCLUSTERED INDEX [IX_AuditLog_AuditDateTime_LoginID_DeviceName]
    ON [dbo].[AuditLog]([AuditDateTime] ASC, [LoginID] ASC, [DeviceName] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_AuditLog_Patient_PatientID]
    ON [dbo].[AuditLog]([PatientID] ASC);

