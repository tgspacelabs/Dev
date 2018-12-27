CREATE TABLE [xref].[TableColumnDataInt] (
    [TableColumnDataIntID] INT IDENTITY (1, 1) NOT NULL,
    [TableColumnInfoID]    INT NOT NULL,
    [Value]                INT NOT NULL,
    CONSTRAINT [PK_TableColumnDataInt_TableColumnDataIntID] PRIMARY KEY CLUSTERED ([TableColumnDataIntID] ASC) WITH (FILLFACTOR = 100),
    CONSTRAINT [FK_TableColumnDataInt_TableColumnInfo_TableColumnInfoID] FOREIGN KEY ([TableColumnInfoID]) REFERENCES [xref].[TableColumnInfo] ([TableColumnInfoID])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TableColumnDataInt_TableColumnInfoID_Value]
    ON [xref].[TableColumnDataInt]([TableColumnInfoID] ASC, [Value] ASC) WITH (FILLFACTOR = 100);

