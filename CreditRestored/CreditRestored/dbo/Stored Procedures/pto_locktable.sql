
/****** Object:  Stored Procedure dbo.pto_locktable    Script Date: 10/13/99 6:38:01 PM ******/


CREATE PROCEDURE pto_locktable 
    @table_name sysname
AS
BEGIN
   EXECUTE ('DECLARE @scratch int IF EXISTS (SELECT * FROM ' + @table_name + ' (TABLOCKX HOLDLOCK)) BEGIN SELECT @scratch = @scratch END')
END
