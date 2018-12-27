
CREATE PROCEDURE [dbo].[GetfaciLities]
AS
  BEGIN
    SELECT ORG.organization_id AS FACILITY_ID,
           ORG.organization_cd AS FACILITY_CODE,
           ORG.organization_nm AS FACILITY_NAME
    FROM   dbo.int_organization ORG
    WHERE  ORG.category_cd = 'F'
    ORDER  BY ORG.organization_cd
  END


