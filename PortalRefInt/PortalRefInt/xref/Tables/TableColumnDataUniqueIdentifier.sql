CREATE TABLE [xref].[TableColumnDataUniqueIdentifier] (
    [TableColumnDataUniqueIdentifierID] INT              IDENTITY (1, 1) NOT NULL,
    [TableColumnInfoID]                 INT              NOT NULL,
    [Value]                             BIGINT NOT NULL,
    CONSTRAINT [PK_TableColumnDataUniqueIdentifier_TableColumnDataUniqueIdentifierID] PRIMARY KEY CLUSTERED ([TableColumnDataUniqueIdentifierID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_TableColumnDataUniqueIdentifier_TableColumnInfo_TableColumnInfoID] FOREIGN KEY ([TableColumnInfoID]) REFERENCES [xref].[TableColumnInfo] ([TableColumnInfoID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TableColumnDataUniqueIdentifier_TableColumnInfoID_Value]
    ON [xref].[TableColumnDataUniqueIdentifier]([TableColumnInfoID] ASC, [Value] ASC) WITH (FILLFACTOR = 100);

