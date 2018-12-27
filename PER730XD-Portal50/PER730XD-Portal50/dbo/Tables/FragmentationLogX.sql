CREATE TABLE [dbo].[FragmentationLogX] (
    [FragmentationLogID]             INT            IDENTITY (1, 1) NOT NULL,
    [LogDateTime]                    DATETIME2 (7)  NOT NULL,
    [DatabaseName]                   NVARCHAR (128) NULL,
    [TableName]                      NVARCHAR (128) NULL,
    [IndexName]                      [sysname]      NULL,
    [index_id]                       INT            NOT NULL,
    [index_level]                    TINYINT        NULL,
    [index_type_desc]                NVARCHAR (60)  NULL,
    [alloc_unit_type_desc]           NVARCHAR (60)  NULL,
    [avg_fragmentation_in_percent]   FLOAT (53)     NULL,
    [avg_fragment_size_in_pages]     FLOAT (53)     NULL,
    [avg_page_space_used_in_percent] FLOAT (53)     NULL,
    [record_count]                   BIGINT         NULL,
    [ghost_record_count]             BIGINT         NULL,
    [fragment_count]                 BIGINT         NULL,
    CONSTRAINT [PK_FragmentationLogX_LogDateTime_FragmentationLogID] PRIMARY KEY CLUSTERED ([LogDateTime] ASC, [FragmentationLogID] ASC)
);

