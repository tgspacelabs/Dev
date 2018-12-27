CREATE TABLE [Utility].[TableRowSpace] (
    [TableRowSpaceID] BIGINT         IDENTITY (-9223372036854775808, 1) NOT NULL,
    [DatabaseName]    NVARCHAR (128) NOT NULL,
    [SchemaName]      NVARCHAR (128) NOT NULL,
    [TableName]       NVARCHAR (128) NOT NULL,
    [IndexName]       NVARCHAR (128) NULL,
    [RowCount]        BIGINT         NOT NULL,
    [TotalSpaceKB]    BIGINT         NOT NULL,
    [UsedSpaceKB]     BIGINT         NOT NULL,
    [UnusedSpaceKB]   BIGINT         NOT NULL,
    [CreatedUTC]      DATETIME2 (7)  NOT NULL,
    [IndexID]         INT            NOT NULL
);

