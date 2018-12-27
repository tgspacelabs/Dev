
--tempdb space usage collection
--The following stored procedure polls DMVs and inserts data into the table called tempdb_space_usage. 
--You can run this procedure as often as necessary. For our workload, we run it every minute.
CREATE PROC [dbo].[sp_sampleTempDbSpaceUsage]
AS --Instance level tempdb File space usage for all files within tempdb
BEGIN
    INSERT  [dbo].[tempdb_space_usage]
            (scope,
             Instance_unallocated_extent_pages,
             version_store_pages,
             Instance_userobj_alloc_pages,
             Instance_internalobj_alloc_pages,
             Instance_mixed_extent_alloc_pages)
    SELECT
        'instance',
        SUM(unallocated_extent_page_count),
        SUM(version_store_reserved_page_count),
        SUM(user_object_reserved_page_count),
        SUM(internal_object_reserved_page_count),
        SUM(mixed_extent_page_count)
    FROM
        [sys].[dm_db_file_space_usage]
    
    -- 2. tempdb space usage per session 
    --
    INSERT  [dbo].[tempdb_space_usage]
            (scope,
             session_id,
             Sess_task_userobj_alloc_pages,
             Sess_task_userobj_deallocated_pages,
             Sess_task_internalobj_alloc_pages,
             Sess_task_internalobj_deallocated_pages)
    SELECT
        'session',
        session_id,
        user_objects_alloc_page_count,
        user_objects_dealloc_page_count,
        internal_objects_alloc_page_count,
        internal_objects_dealloc_page_count
    FROM
        [sys].[dm_db_session_space_usage]
    WHERE
        session_id > 50

    -- 3. tempdb space usage per active task
    --
    INSERT  [dbo].[tempdb_space_usage]
            (scope,
             session_id,
             Sess_task_userobj_alloc_pages,
             Sess_task_userobj_deallocated_pages,
             Sess_task_internalobj_alloc_pages,
             Sess_task_internalobj_deallocated_pages,
             query_text)
    SELECT
        'task',
        [R1].[session_id],
        [R1].[user_objects_alloc_page_count],
        [R1].[user_objects_dealloc_page_count],
        [R1].[internal_objects_alloc_page_count],
        [R1].[internal_objects_dealloc_page_count],
        [R3].[text]
    FROM
        [sys].[dm_db_task_space_usage] AS R1
        LEFT OUTER JOIN [sys].[dm_exec_requests] AS R2
            ON [R1].[session_id] = [R2].[session_id]
        OUTER APPLY [sys].[dm_exec_sql_text]([R2].[sql_handle]) AS R3
    WHERE
        [R1].[session_id] > 50
END

--tempdb space usage analysis
--This is a test scenario based on a TPC-H database. Three of the TPC-H queries were specifically chosen to allocate space in tempdb. Other queries generate DML activity on the base tables.

--None of these queries create objects in tempdb, so the user object level queries in the tempdb space usage collection section in this paper are not important in this scenario. All of the sessions that connect to the test server run a procedure, exit, reconnect, and repeat. Therefore, session scope queries are not as important in this scenario. This might not be true in production systems, particularly those running ad-hoc queries.

--We use the following queries to analyze tempdb space usage in our workload.

--Query1: This query reports the maximum allocated space in tempdb over all the data points collected. You can use this to estimate the size requirements of tempdb for your workload. This query reports tempdb space usage at the instance level.
    SELECT
        CONVERT (FLOAT, (MAX(version_store_pages + Instance_userobj_alloc_pages + Instance_internalobj_alloc_pages + Instance_mixed_extent_alloc_pages)))
        / 128.0 AS max_tempdb_allocation_MB
    FROM
        [dbo].[tempdb_space_usage]
    WHERE
        scope = 'instance'

--Query2: This query reports the average allocated space in tempdb over all the data points collected. This query reports average tempdb space usage at the instance level.
    SELECT
        CONVERT (FLOAT, (AVG(version_store_pages + Instance_userobj_alloc_pages + Instance_internalobj_alloc_pages + Instance_mixed_extent_alloc_pages)))
        / 128.0 AS avg_tempdb_allocation_MB
    FROM
        [dbo].[tempdb_space_usage]
    WHERE
        scope = 'instance'

--Query3: This query computes the maximum allocated pages and the verison store size in megabytes over all the data points collected. If the amount of tempdb space that is allocated to the version store is large, it implies that long-running transactions are generating or consuming versions.  
    SELECT
        MAX(version_store_pages) AS max_version_store_pages_allocated,
        MAX(version_store_pages / 128.0) AS max_version_store_allocated_space_MB
    FROM
        [dbo].[tempdb_space_usage]
    WHERE
        scope = 'instance' 

--Query4: This query computes the average number of allocated pages and the verison store size in megabytes over all the data points collected.
    SELECT
        AVG(version_store_pages) AS max_version_store_pages_allocated,
        AVG(version_store_pages) / 128.0 AS max_version_store_allocated_space_MB
    FROM
        [dbo].[tempdb_space_usage]
    WHERE
        scope = 'instance'
