CREATE TABLE [dbo].[TranslateList] (
    [TranslateListID] INT           IDENTITY (1, 1) NOT NULL,
    [ListID]          INT           NOT NULL,
    [TranslateCode]   VARCHAR (40)  NOT NULL,
    [CreatedDateTime] DATETIME2 (7) CONSTRAINT [DF_TranslateList_CreatedDateTime] DEFAULT (sysutcdatetime()) NOT NULL,
    CONSTRAINT [PK_TranslateList_TranslateListID] PRIMARY KEY CLUSTERED ([TranslateListID] ASC)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TranslateList_ListID_TranslateCode]
    ON [dbo].[TranslateList]([ListID] ASC, [TranslateCode] ASC);

