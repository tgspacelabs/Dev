CREATE TABLE [xref].[TableColumnInfo] (
    [TableColumnInfoID] INT            IDENTITY (1, 1) NOT NULL,
    [SchemaName]        NVARCHAR (128) NOT NULL,
    [TableName]         NVARCHAR (128) NOT NULL,
    [ColumnName]        NVARCHAR (128) NOT NULL,
    [ColumnID]          INT            NOT NULL,
    [DataType]          NVARCHAR (128) NOT NULL,
    [MaxLength]         SMALLINT       NOT NULL,
    [Scale]             TINYINT        NOT NULL,
    [Precision]         TINYINT        NOT NULL,
    [Number]            BIT            NOT NULL,
    [Excluded]          BIT            NOT NULL,
    CONSTRAINT [PK_TableColumnInfo_TableColumnInfoID] PRIMARY KEY CLUSTERED ([TableColumnInfoID] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_TableColumnInfo_SchemaName_TableName_ColumnName]
    ON [xref].[TableColumnInfo]([SchemaName] ASC, [TableName] ASC, [ColumnName] ASC) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_TableColumnInfo_DataType]
    ON [xref].[TableColumnInfo]([DataType] ASC) WITH (FILLFACTOR = 100);

