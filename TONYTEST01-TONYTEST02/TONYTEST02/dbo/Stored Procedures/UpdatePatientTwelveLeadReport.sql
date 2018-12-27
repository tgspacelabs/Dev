
CREATE PROCEDURE [dbo].[UpdatePatientTwelveLeadReport]
  (
  @report_id      UNIQUEIDENTIFIER,
  @Interpretation VARCHAR(256)
  )
AS
  BEGIN
    UPDATE dbo.int_12lead_report_new
    SET    interpretation = @Interpretation
    WHERE  ( report_id = @report_id )
  END


