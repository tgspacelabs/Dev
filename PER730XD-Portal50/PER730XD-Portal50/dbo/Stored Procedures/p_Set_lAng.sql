
CREATE PROCEDURE [dbo].[p_Set_lAng]
  (
  @ICSLang NVARCHAR(10)
  )
AS
  BEGIN
    IF NOT EXISTS
           ( SELECT keyvalue
             FROM   int_cfg_values
             WHERE  keyname = 'Language' )
      BEGIN
        INSERT INTO int_cfg_values
        VALUES      ('Language',
                     @ICSLang)
      END
    ELSE
      UPDATE int_cfg_values
      SET    keyvalue = @ICSLang
      WHERE  ( keyname = 'Language' )
  END
