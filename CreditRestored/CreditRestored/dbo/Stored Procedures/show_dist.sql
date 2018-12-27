
/****** Object:  Stored Procedure dbo.show_dist    Script Date: 10/13/99 6:38:01 PM ******/

CREATE PROCEDURE show_dist 
    @table  sysname
  , @column sysname
AS
BEGIN
   CREATE TABLE #temp_table ( NUMBER_THAT_HAVE int NULL
                            , THIS_MANY        int NULL
                            )
   EXEC ("INSERT INTO #temp_table SELECT " + @column + ", COUNT(*) FROM " + @table + " GROUP BY " + @column)
   EXEC ("SELECT 'NUMBER THAT HAVE' = COUNT(*), THIS_MANY FROM #temp_table GROUP BY THIS_MANY ORDER BY THIS_MANY DESC") 
   DROP TABLE #temp_table
END
