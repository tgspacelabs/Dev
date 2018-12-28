CREATE TABLE [dbo].[Gender] (
    [GenderID]        TINYINT       IDENTITY (1, 1) NOT NULL,
    [Name]            VARCHAR (50)  CONSTRAINT [DF__Gender__Name__4BAC3F29] DEFAULT ('') NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF__Gender__CreatedD__4CA06362] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_Gender_GenderID] PRIMARY KEY CLUSTERED ([GenderID] ASC)
);

