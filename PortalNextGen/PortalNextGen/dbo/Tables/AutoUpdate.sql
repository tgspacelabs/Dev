CREATE TABLE [dbo].[AutoUpdate] (
    [AutoUpdateID]    INT           IDENTITY (1, 1) NOT NULL,
    [Product]         CHAR (3)      NULL,
    [Sequence]        INT           NULL,
    [Action]          VARCHAR (255) NOT NULL,
    [Disabled]        TINYINT       NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_AutoUpdate_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_AutoUpdate_AutoUpdateID] PRIMARY KEY CLUSTERED ([AutoUpdateID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AutoUpdate_Sequence_Prod]
    ON [dbo].[AutoUpdate]([Sequence] ASC, [Product] ASC);

