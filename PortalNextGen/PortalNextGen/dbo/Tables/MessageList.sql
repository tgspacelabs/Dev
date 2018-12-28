CREATE TABLE [dbo].[MessageList] (
    [MessageListID]   INT           IDENTITY (1, 1) NOT NULL,
    [ListName]        NVARCHAR (20) NOT NULL,
    [MessageNumber]   INT           NOT NULL,
    [Sequence]        INT           NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_MessageList_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_MessageList_MessageListID] PRIMARY KEY CLUSTERED ([MessageListID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_MessageList_ListName_Sequence_MessageNumber]
    ON [dbo].[MessageList]([ListName] ASC, [Sequence] ASC, [MessageNumber] ASC);

