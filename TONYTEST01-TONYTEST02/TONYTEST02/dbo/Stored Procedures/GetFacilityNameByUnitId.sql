


CREATE PROCEDURE [dbo].[GetFacilityNameByUnitId]
  (
  @unit_id AS UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT organization_nm
    FROM   int_organization
    WHERE  organization_id =
           ( SELECT parent_organization_id
             FROM   int_organization
             WHERE  organization_id = @unit_id )
  END


