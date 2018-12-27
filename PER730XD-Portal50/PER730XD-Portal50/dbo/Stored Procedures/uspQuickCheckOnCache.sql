
CREATE PROCEDURE [dbo].[uspQuickCheckOnCache]
    @StringToFind NVARCHAR (4000)
AS
SELECT [st].[text], [qs].[execution_count], [qs].*, [p].* 
FROM sys.dm_exec_query_stats AS [qs] 
    CROSS APPLY sys.dm_exec_sql_text ([sql_handle]) [st]
    CROSS APPLY sys.dm_exec_query_plan ([plan_handle]) [p]
WHERE [st].[text] LIKE @StringToFind
ORDER BY [qs].[execution_count] DESC;
