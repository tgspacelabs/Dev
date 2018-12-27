
CREATE PROCEDURE [dbo].[UpdateUserSetting]
  (
  @user_id       UNIQUEIDENTIFIER,
  @cfg_name      VARCHAR(40),
  @cfg_xml_value XML
  )
AS
  BEGIN
    IF NOT EXISTS
           ( SELECT cfg_xml_value
             FROM   dbo.int_user_settings
             WHERE  user_id = @user_id AND cfg_name = @cfg_name )
      BEGIN
        INSERT INTO int_user_settings
                    (user_id,
                     cfg_xml_value,
                     cfg_name)
        VALUES      (@user_id,
                     @cfg_xml_value,
                     @cfg_name)
      END
    ELSE
      BEGIN
        UPDATE dbo.int_user_settings
        SET    cfg_xml_value = @cfg_xml_value
        WHERE  user_id = @user_id AND cfg_name = @cfg_name

      END
  END

