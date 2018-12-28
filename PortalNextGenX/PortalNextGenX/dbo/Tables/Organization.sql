CREATE TABLE [dbo].[Organization] (
    [OrganizationID]  INT           IDENTITY (1, 1) NOT NULL,
    [Name]            NVARCHAR (50) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Organization_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Organization] PRIMARY KEY CLUSTERED ([OrganizationID] ASC)
);

