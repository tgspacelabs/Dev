CREATE TABLE [xref].[TableColumnInfoData] (
    [TableColumnInfoDataID] INT            IDENTITY (1, 1) NOT NULL,
    [SchemaName]            NVARCHAR (128) NOT NULL,
    [TableName]             NVARCHAR (128) NOT NULL,
    [ColumnName]            NVARCHAR (128) NOT NULL,
    [ColumnID]              INT            NOT NULL,
    [DataType]              NVARCHAR (128) NOT NULL,
    [MaxLength]             SMALLINT       NOT NULL,
    [Scale]                 TINYINT        NOT NULL,
    [Precision]             TINYINT        NOT NULL,
    [Value]                 SQL_VARIANT    NOT NULL,
    CONSTRAINT [PK_TableColumnInfoData_TableColumnInfoDataID] PRIMARY KEY CLUSTERED ([TableColumnInfoDataID] ASC) WITH (FILLFACTOR = 100)
);

