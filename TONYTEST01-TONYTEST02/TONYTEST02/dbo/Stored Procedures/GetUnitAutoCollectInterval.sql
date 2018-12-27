
CREATE PROCEDURE [dbo].[GetUnitAutoCollectInterval]
  (
  @unit_id UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT auto_collect_interval AS INTERVAL
    FROM   int_organization
    WHERE  category_cd = 'D' AND organization_id = @unit_id
  END


