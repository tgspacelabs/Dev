
CREATE PROCEDURE [dbo].[DeleteBeatTimeLog]
  (
  @UserID    DUSER_ID,
  @PatientID DPATIENT_ID,
  @SampleRate SMALLINT
  )
AS
  BEGIN
    DELETE dbo.int_beat_time_log
    WHERE  ( user_id = @UserID AND patient_id = @PatientID AND sample_rate = @SampleRate)
  END

