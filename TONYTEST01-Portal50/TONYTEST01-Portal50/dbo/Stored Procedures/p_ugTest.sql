
CREATE PROCEDURE [dbo].[p_ugTest]
  (
  @table VARCHAR(80),
  @col   VARCHAR(80)
  )
AS
  DECLARE @sqlstr VARCHAR(255)

  SET @sqlstr = 'SELECT ' + @col + ' FROM ' + @table

  EXEC (@sqlstr)

