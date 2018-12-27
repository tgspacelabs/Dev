
CREATE PROCEDURE [dbo].[p_Get_lAng]
AS
  DECLARE @my_keyvalue NVARCHAR(100)

  BEGIN
    SELECT @my_keyvalue = keyvalue
    FROM   int_cfg_values
    WHERE  ( keyname = 'Language' )

    IF @my_keyvalue = ''
      BEGIN
        UPDATE int_cfg_values
        SET    keyvalue = 'ENU'
        WHERE  ( keyname = 'Language' )

        SET @my_keyvalue = 'ENU'
      END
    ELSE IF @my_keyvalue IS NULL
      BEGIN
        INSERT INTO int_cfg_values
        VALUES      ('Language',
                     'ENU')

        SET @my_keyvalue = 'ENU'
      END

    SELECT @my_keyvalue AS KEYVALUE
  END

