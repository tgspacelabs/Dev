CREATE TABLE [dbo].[ProductAccess] (
    [ProductAccessID] INT           IDENTITY (1, 1) NOT NULL,
    [ProductCode]     VARCHAR (25)  NOT NULL,
    [OrganizationID]  INT           NULL,
    [LicenseNumber]   VARCHAR (120) NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_ProductAccess_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ProductAccess_ProductAccessID] PRIMARY KEY CLUSTERED ([ProductAccessID] ASC),
    CONSTRAINT [FK_ProductAccess_Organization_OrganizationID] FOREIGN KEY ([OrganizationID]) REFERENCES [dbo].[Organization] ([OrganizationID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_ProductAccess_ProductCode_OrganizationID]
    ON [dbo].[ProductAccess]([ProductCode] ASC, [OrganizationID] ASC);


GO
CREATE NONCLUSTERED INDEX [FK_ProductAccess_Organization_OrganizationID]
    ON [dbo].[ProductAccess]([OrganizationID] ASC);

