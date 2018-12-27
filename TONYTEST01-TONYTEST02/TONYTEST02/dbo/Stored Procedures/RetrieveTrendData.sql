
CREATE PROCEDURE [dbo].[RetrieveTrendData]
  (
  @UserID    DUSER_ID,
  @PatientID DPATIENT_ID
  )
AS
  BEGIN
    SELECT user_id,
           patient_id,
           total_categories,
           start_ft,
           total_periods,
           samples_per_period,
           trend_data
    FROM   dbo.TrendData
    WHERE  ( user_id = @UserID AND patient_id = @PatientID )
  END


