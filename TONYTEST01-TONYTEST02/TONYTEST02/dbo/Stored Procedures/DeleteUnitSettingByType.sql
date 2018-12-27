
CREATE PROCEDURE [dbo].[DeleteUnitSettingByType]
  (
  @UnitID  UNIQUEIDENTIFIER,
  @TypeCd  VARCHAR(25),
  @CfgName VARCHAR(40)
  )
AS
  BEGIN
    DELETE cfgValuesUnit
    WHERE  ( unit_id = @UnitID ) AND ( type_cd = @TypeCd ) AND ( cfg_name = @CfgName )
  END


