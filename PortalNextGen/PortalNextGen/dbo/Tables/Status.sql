CREATE TABLE [dbo].[Status] (
    [StatusID]        INT           IDENTITY (1, 1) NOT NULL,
    [SetID]           INT           NOT NULL,
    [Name]            VARCHAR (25)  NOT NULL,
    [Value]           VARCHAR (25)  NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_Status_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Status_StatusID] PRIMARY KEY CLUSTERED ([StatusID] ASC)
);

