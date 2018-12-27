
CREATE PROCEDURE [dbo].[RetrieveBeatTimeLog]
  (
  @UserID    DUSER_ID,
  @PatientID DPATIENT_ID
  )
AS
  BEGIN
    SELECT user_id,
           patient_id,
           start_ft,
           num_beats,
           sample_rate,
           beat_data
    FROM   dbo.int_beat_time_log
    WHERE  ( user_id = @UserID AND patient_id = @PatientID )
  END

