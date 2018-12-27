CREATE TABLE [dbo].[tbl_ConfigurationData] (
    [ApplicationName]     NVARCHAR (256) NOT NULL,
    [SectionName]         NVARCHAR (150) NOT NULL,
    [SectionData]         XML            NULL,
    [UpdatedTimeStampUTC] DATETIME       NULL,
    CONSTRAINT [PK_ConfigurationData_ApplicationName_SectionName] PRIMARY KEY CLUSTERED ([ApplicationName] ASC, [SectionName] ASC)
);

