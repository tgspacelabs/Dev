
CREATE PROCEDURE [dbo].[p_Set_cfg_Values]
  (
  @keyname  VARCHAR(40),
  @keyvalue VARCHAR(100)
  )
AS
  BEGIN
    UPDATE dbo.int_cfg_values
    SET    keyvalue = @keyvalue
    WHERE  keyname = @keyname
  END

