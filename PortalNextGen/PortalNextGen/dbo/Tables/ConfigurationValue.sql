CREATE TABLE [dbo].[ConfigurationValue] (
    [KeyName]         VARCHAR (40)  NOT NULL,
    [KeyValue]        VARCHAR (100) NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_ConfigurationValue_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_ConfigurationValue_KeyName] PRIMARY KEY CLUSTERED ([KeyName] ASC)
);

