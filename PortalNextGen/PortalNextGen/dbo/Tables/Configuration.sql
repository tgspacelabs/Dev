CREATE TABLE [dbo].[Configuration] (
    [ConfigurationID] INT            IDENTITY (1, 1) NOT NULL,
    [ApplicationName] NVARCHAR (256) NOT NULL,
    [SectionName]     NVARCHAR (150) NOT NULL,
    [SectionData]     XML            NULL,
    [UpdatedDateTime] DATETIME2 (7)  NULL,
    [CreatedDateTime] DATETIME2 (7)  CONSTRAINT [DF_Configuration_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Configuration_ConfigurationID] PRIMARY KEY CLUSTERED ([ConfigurationID] ASC)
);

