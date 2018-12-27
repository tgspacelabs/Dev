
CREATE PROCEDURE [dbo].[GetvsvAccess]
  (
  @patient_monitor_id UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT 1
    FROM   dbo.int_patient_monitor PM
           INNER JOIN dbo.int_monitor M
             ON M.monitor_id = PM.monitor_id AND PM.patient_monitor_id = @patient_monitor_id
           INNER JOIN dbo.int_product_access PA
             ON PA.organization_id = M.unit_org_id AND PA.product_cd = 'vsv'
  END


