CREATE TABLE [dbo].[AutoUpdateLog] (
    [AutoUpdateLogID] INT           IDENTITY (1, 1) NOT NULL,
    [Machine]         NVARCHAR (50) NOT NULL,
    [ActionDateTime]  DATETIME2 (7) NOT NULL,
    [Product]         CHAR (3)      NOT NULL,
    [Success]         TINYINT       NOT NULL,
    [Reason]          NVARCHAR (80) NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_AutoUpdateLog_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_AutoUpdateLog_AutoUpdateLogID] PRIMARY KEY CLUSTERED ([AutoUpdateLogID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_AutoUpdateLog_Machine_ActionDateTime_Prod]
    ON [dbo].[AutoUpdateLog]([Machine] ASC, [ActionDateTime] ASC, [Product] ASC);

