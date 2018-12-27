
CREATE PROCEDURE [dbo].[p_Get_cfg_Values]
  (
  @keyname VARCHAR(40)
  )
AS
  BEGIN
    SELECT keyvalue
    FROM   dbo.int_cfg_values
    WHERE  keyname = @keyname
  END

