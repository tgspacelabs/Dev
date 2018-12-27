CREATE TABLE [xref].[TableColumnDataLink] (
    [TableColumnDataLinkID] INT         IDENTITY (1, 1) NOT NULL,
    [TableColumnDataID1]    INT         NOT NULL,
    [TableColumnDataID2]    INT         NOT NULL,
    [Value]                 SQL_VARIANT NOT NULL,
    CONSTRAINT [PK_TableColumnDataLink_TableColumnDataLinkID] PRIMARY KEY CLUSTERED ([TableColumnDataLinkID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_TableColumnDataLink_TableColumnInfo_TableColumnDataID1] FOREIGN KEY ([TableColumnDataID1]) REFERENCES [xref].[TableColumnData] ([TableColumnDataID]),
    CONSTRAINT [FK_TableColumnDataLink_TableColumnInfo_TableColumnDataID2] FOREIGN KEY ([TableColumnDataID2]) REFERENCES [xref].[TableColumnData] ([TableColumnDataID])
);


GO
CREATE NONCLUSTERED INDEX [IX_TableColumnDataLink_TableColumnDataID1]
    ON [xref].[TableColumnDataLink]([TableColumnDataID1] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_TableColumnDataLink_TableColumnDataID2]
    ON [xref].[TableColumnDataLink]([TableColumnDataID2] ASC) WITH (FILLFACTOR = 100);

