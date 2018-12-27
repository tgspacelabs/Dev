CREATE TABLE [xref].[TableColumnData] (
    [TableColumnDataID] INT         IDENTITY (1, 1) NOT NULL,
    [TableColumnInfoID] INT         NOT NULL,
    [Value]             SQL_VARIANT NOT NULL,
    CONSTRAINT [PK_TableColumnData_TableColumnDataID] PRIMARY KEY CLUSTERED ([TableColumnDataID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_TableColumnData_TableColumnInfo_TableColumnInfoID] FOREIGN KEY ([TableColumnInfoID]) REFERENCES [xref].[TableColumnInfo] ([TableColumnInfoID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TableColumnData_TableColumnInfoID_Value]
    ON [xref].[TableColumnData]([TableColumnInfoID] ASC, [Value] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_TableColumnData_TableColumnInfoID]
    ON [xref].[TableColumnData]([TableColumnInfoID] ASC) WITH (FILLFACTOR = 100);

