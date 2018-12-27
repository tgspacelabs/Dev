
CREATE PROCEDURE [dbo].[DeletePatientTwelveLeadReport]
  (
  @report_id UNIQUEIDENTIFIER
  )
AS
  BEGIN
    DELETE FROM dbo.int_12lead_report
    WHERE  ( report_id = @report_id )
  END

