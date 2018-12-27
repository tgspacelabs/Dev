
CREATE PROCEDURE [dbo].[p_Test_Groups]
  (
  @node_id INT
  )
AS
  DECLARE @level INT

  SET @level = 0

  SET NOCOUNT ON

  SELECT node_id,
         rank,
         parent_node_id,
         node_name,
         @level LEVEL
  INTO   #TMP_NODES
  FROM   cdr_test_group
  WHERE  node_id = @node_id

  WHILE ( @@ROWCOUNT <> 0 )
    BEGIN
      SET @level = @level + 1

      INSERT INTO #TMP_NODES
        SELECT node_id,
               rank,
               parent_node_id,
               node_name,
               @level
        FROM   cdr_test_group
        WHERE  parent_node_id IN
               ( SELECT node_id
                 FROM   #TMP_NODES ) AND node_id NOT IN ( SELECT node_id
                                    FROM   #TMP_NODES )
    END

  SET NOCOUNT OFF

  SELECT *
  FROM   #TMP_NODES
  ORDER  BY rank

  DROP TABLE #TMP_NODES




GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'p_Test_Groups';

