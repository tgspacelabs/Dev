
CREATE PROCEDURE [dbo].[GetIntcfgValues]
  (
  @keyname DKEY_NAME
  )
AS
  BEGIN
    SELECT keyvalue AS KEY_VALUE
    FROM   dbo.int_cfg_values
    WHERE  keyname = @keyname
  END

