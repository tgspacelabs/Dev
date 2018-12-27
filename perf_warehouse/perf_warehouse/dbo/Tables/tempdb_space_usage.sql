CREATE TABLE [dbo].[tempdb_space_usage] (
    [dt]                                      DATETIME       DEFAULT (getdate()) NULL,
    [session_id]                              INT            DEFAULT (NULL) NULL,
    [scope]                                   CHAR (7)       NULL,
    [Instance_unallocated_extent_pages]       BIGINT         NULL,
    [version_store_pages]                     BIGINT         NULL,
    [Instance_userobj_alloc_pages]            BIGINT         NULL,
    [Instance_internalobj_alloc_pages]        BIGINT         NULL,
    [Instance_mixed_extent_alloc_pages]       BIGINT         NULL,
    [Sess_task_userobj_alloc_pages]           BIGINT         NULL,
    [Sess_task_userobj_deallocated_pages]     BIGINT         NULL,
    [Sess_task_internalobj_alloc_pages]       BIGINT         NULL,
    [Sess_task_internalobj_deallocated_pages] BIGINT         NULL,
    [query_text]                              NVARCHAR (MAX) NULL
);


GO
CREATE CLUSTERED INDEX [cidx]
    ON [dbo].[tempdb_space_usage]([dt] ASC);

