

CREATE PROCEDURE [dbo].[GetPatientTwelveLeadReports]
  (
  @patient_id UNIQUEIDENTIFIER
  )
AS
  BEGIN
    SELECT report_id,
           report_dt
    FROM   dbo.int_12lead_report
    WHERE  ( patient_id = @patient_id )
    ORDER  BY report_dt DESC

  END

