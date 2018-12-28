CREATE TABLE [dbo].[MessageLog] (
    [MessageLogID]      INT            IDENTITY (1, 1) NOT NULL,
    [MessageDateTime]   DATETIME2 (7)  NOT NULL,
    [Product]           NVARCHAR (20)  NOT NULL,
    [MessageTemplateID] INT            NOT NULL,
    [ExternalID]        VARCHAR (50)   NOT NULL,
    [MessageText]       NVARCHAR (MAX) NOT NULL,
    [Type]              NVARCHAR (20)  NOT NULL,
    [CreatedDateTime]   DATETIME2 (7)  CONSTRAINT [DF_MessageLog_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MessageLog_MessageLogID] PRIMARY KEY CLUSTERED ([MessageLogID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MessageLog_ExternalID_MessageLogID]
    ON [dbo].[MessageLog]([ExternalID] ASC, [MessageLogID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_MessageLog_MessageDateTime]
    ON [dbo].[MessageLog]([MessageDateTime] ASC);

