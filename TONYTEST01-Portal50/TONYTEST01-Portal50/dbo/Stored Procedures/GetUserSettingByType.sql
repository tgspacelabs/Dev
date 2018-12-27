
CREATE PROCEDURE [dbo].[GetUserSettingByType]
  (
  @user_id  AS UNIQUEIDENTIFIER,
  @cfg_name AS VARCHAR(40)
  )
AS
  BEGIN
    SELECT cfg_xml_value AS CFGXMLVALUE
    FROM   dbo.int_user_settings
    WHERE  user_id = @user_id AND cfg_name = @cfg_name

  END

