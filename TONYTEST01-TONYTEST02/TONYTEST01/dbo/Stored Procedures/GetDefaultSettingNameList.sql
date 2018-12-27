  

CREATE PROCEDURE [dbo].[GetDefaultSettingNameList]
  (
  @type_cd AS VARCHAR(25)
  )
AS
  BEGIN
    SELECT cfg_name AS CFGNAME
    FROM   dbo.CfgValuesFactory
    WHERE  type_cd = @type_cd

  END

