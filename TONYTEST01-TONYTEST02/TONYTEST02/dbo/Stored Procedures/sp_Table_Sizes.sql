﻿
CREATE PROCEDURE [dbo].[sp_Table_Sizes]
AS
  DECLARE
    @tname VARCHAR(100),
    @sql   VARCHAR(100)
  DECLARE TCURSOR CURSOR FOR
    SELECT name
    FROM   sysobjects
    WHERE  name LIKE 'int_%'

  SET NOCOUNT ON

  OPEN TCURSOR

  FETCH NEXT FROM TCURSOR INTO @tname

  WHILE ( @@FETCH_STATUS = 0 )
    BEGIN
      EXEC sp_SpaceUsed @tname

      FETCH NEXT FROM TCURSOR INTO @tname
    END

  CLOSE TCURSOR

  DEALLOCATE TCURSOR


