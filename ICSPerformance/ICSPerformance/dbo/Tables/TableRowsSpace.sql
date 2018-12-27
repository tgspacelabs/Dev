CREATE TABLE [dbo].[TableRowsSpace] (
    [SchemaName]    NVARCHAR (128) NOT NULL,
    [TableName]     NVARCHAR (128) NOT NULL,
    [IndexName]     NVARCHAR (128) NULL,
    [RowCounts]     BIGINT         NULL,
    [TotalSpaceKB]  BIGINT         NULL,
    [UsedSpaceKB]   BIGINT         NULL,
    [UnusedSpaceKB] BIGINT         NULL
);

