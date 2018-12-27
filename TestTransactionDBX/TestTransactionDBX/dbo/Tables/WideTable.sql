CREATE TABLE [dbo].[WideTable] (
    [ID]         INT         NOT NULL,
    [RandomInt]  INT         NOT NULL,
    [CharFiller] CHAR (1000) NULL,
    CONSTRAINT [PK_WideTable] PRIMARY KEY CLUSTERED ([ID] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [WideTable_RandomInt]
    ON [dbo].[WideTable]([RandomInt] ASC) WITH (FILLFACTOR = 100);

