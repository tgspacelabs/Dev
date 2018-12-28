CREATE TABLE [dbo].[SystemGeneration] (
    [SystemGenerationID] INT           IDENTITY (1, 1) NOT NULL,
    [ProductCode]        VARCHAR (25)  NOT NULL,
    [FeatureCode]        VARCHAR (25)  NOT NULL,
    [Setting]            VARCHAR (80)  NULL,
    [CreatedDateTime]    DATETIME2 (7) CONSTRAINT [DF_SystemGeneration_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_SystemGeneration_SystemGenerationID] PRIMARY KEY CLUSTERED ([SystemGenerationID] ASC)
);

