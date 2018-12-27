
CREATE PROCEDURE [dbo].[DeleteUnitSetting]
  (
  @UnitID UNIQUEIDENTIFIER
  )
AS
  BEGIN
    DELETE cfgValuesUnit
    WHERE  ( unit_id = @UnitID )
  END


