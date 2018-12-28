CREATE TABLE [dbo].[PrintRequestDescription] (
    [PrintRequestDescriptionID] INT           IDENTITY (1, 1) NOT NULL,
    [RequestTypeEnumID]         INT           NOT NULL,
    [RequestTypeEnumValue]      INT           NOT NULL,
    [Value]                     VARCHAR (25)  NOT NULL,
    [CreatedDateTime]           DATETIME2 (7) CONSTRAINT [DF_PrintRequestDescription_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_PrintRequestDescription_PrintRequestDescriptionID] PRIMARY KEY CLUSTERED ([PrintRequestDescriptionID] ASC)
);

