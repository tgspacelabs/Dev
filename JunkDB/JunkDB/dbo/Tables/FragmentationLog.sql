CREATE TABLE [dbo].[FragmentationLog] (
    [LogDateTime]                    DATETIME2 (7)  NOT NULL,
    [DatabaseName]                   NVARCHAR (128) NULL,
    [TableName]                      NVARCHAR (128) NULL,
    [index_id]                       INT            NULL,
    [IndexName]                      NVARCHAR (128) NULL,
    [avg_fragmentation_in_percent]   FLOAT (53)     NULL,
    [avg_page_space_used_in_percent] FLOAT (53)     NULL,
    [index_type_desc]                NVARCHAR (60)  NULL
);

