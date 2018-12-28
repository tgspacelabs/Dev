CREATE TABLE [dbo].[ExternalOrganization] (
    [ExternalOrganizationID]       INT           IDENTITY (1, 1) NOT NULL,
    [CategoryCode]                 NCHAR (1)     NULL,
    [OrganizationName]             NVARCHAR (50) NULL,
    [ParentExternalOrganizationID] INT           NULL,
    [OrganizationCode]             NVARCHAR (30) NULL,
    [CompanyCons]                  NVARCHAR (50) NULL,
    [CreatedDateTime]              DATETIME2 (7) CONSTRAINT [DF_ExternalOrganization_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ExternalOrganization_ExternalOrganizationID] PRIMARY KEY CLUSTERED ([ExternalOrganizationID] ASC)
);

