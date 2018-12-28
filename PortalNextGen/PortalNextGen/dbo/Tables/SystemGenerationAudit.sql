CREATE TABLE [dbo].[SystemGenerationAudit] (
    [SystemGenerationAuditID] INT           IDENTITY (1, 1) NOT NULL,
    [AuditDateTime]           DATETIME2 (7) NOT NULL,
    [Audit]                   VARCHAR (255) NOT NULL,
    [CreatedDateTime]         DATETIME2 (7) CONSTRAINT [DF_SystemGenerationAudit_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SystemGenerationAudit_SystemGenerationAuditID] PRIMARY KEY CLUSTERED ([SystemGenerationAuditID] ASC)
);

