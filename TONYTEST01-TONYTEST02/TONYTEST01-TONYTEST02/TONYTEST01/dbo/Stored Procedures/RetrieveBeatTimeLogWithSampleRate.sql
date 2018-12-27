
CREATE PROCEDURE [dbo].[RetrieveBeatTimeLogWithSampleRate]
  (
  @UserID    DUSER_ID,
  @PatientID DPATIENT_ID,
  @SampleRate SMALLINT
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
    WHERE  ( user_id = @UserID AND patient_id = @PatientID AND sample_rate = @SampleRate )
  END
