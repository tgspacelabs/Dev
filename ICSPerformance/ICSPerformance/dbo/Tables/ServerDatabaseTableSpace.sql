CREATE TABLE [dbo].[ServerDatabaseTableSpace] (
    [ServerDatabaseTableSpaceID] INT            IDENTITY (1, 1) NOT NULL,
    [SourceName]                 NVARCHAR (256) NULL,
    [DatabaseName]               NVARCHAR (128) NULL,
    [SchemaName]                 NVARCHAR (128) NOT NULL,
    [TableName]                  NVARCHAR (128) NOT NULL,
    [IndexName]                  NVARCHAR (128) NULL,
    [RowCounts]                  BIGINT         NULL,
    [TotalSpaceKB]               BIGINT         NULL,
    [UsedSpaceKB]                BIGINT         NULL,
    [UnusedSpaceKB]              BIGINT         NULL,
    [CreatedDateTime]            DATETIME2 (7)  CONSTRAINT [DF_CreatedDateTime] DEFAULT (sysdatetime()) NOT NULL,
    PRIMARY KEY CLUSTERED ([ServerDatabaseTableSpaceID] ASC)
);

