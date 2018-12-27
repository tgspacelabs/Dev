CREATE TABLE [dbo].[TableRowsSpace-NoIndex] (
    [SchemaName]    NVARCHAR (128) NOT NULL,
    [TableName]     NVARCHAR (128) NOT NULL,
    [RowCounts]     BIGINT         NULL,
    [TotalSpaceKB]  BIGINT         NULL,
    [UsedSpaceKB]   BIGINT         NULL,
    [UnusedSpaceKB] BIGINT         NULL
);

