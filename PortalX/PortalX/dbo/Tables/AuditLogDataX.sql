CREATE TABLE [dbo].[AuditLogDataX] (
    [AuditId]       UNIQUEIDENTIFIER NOT NULL,
    [DateTime]      DATETIME         NOT NULL,
    [PatientID]     VARCHAR (256)    NOT NULL,
    [Application]   NVARCHAR (256)   NULL,
    [DeviceName]    NVARCHAR (256)   NULL,
    [Message]       NVARCHAR (MAX)   NOT NULL,
    [ItemName]      NVARCHAR (256)   NOT NULL,
    [OriginalValue] NVARCHAR (MAX)   NOT NULL,
    [NewValue]      NVARCHAR (MAX)   NOT NULL,
    [ChangedBy]     NVARCHAR (64)    NOT NULL,
    [HashedValue]   BINARY (20)      NOT NULL
);

