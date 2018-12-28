CREATE TABLE [dbo].[SendSystem] (
    [SendSystemID]    INT            IDENTITY (1, 1) NOT NULL,
    [FlowsheetID]     INT            NOT NULL,
    [SystemID]        INT            NOT NULL,
    [OrganizationID]  INT            NOT NULL,
    [Code]            NVARCHAR (180) NOT NULL,
    [Description]     NVARCHAR (180) NULL,
    [CreatedDateTime] DATETIME2 (7)  CONSTRAINT [DF_SendSystem_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SendSystem_SendSystemID] PRIMARY KEY CLUSTERED ([SendSystemID] ASC),
    CONSTRAINT [FK_SendSystem_Organization_OrganizationID] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_SendSystem_SystemID]
    ON [dbo].[SendSystem]([SystemID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_SendSystem_Organization_OrganizationID]
    ON [dbo].[SendSystem]([OrganizationID] ASC);

