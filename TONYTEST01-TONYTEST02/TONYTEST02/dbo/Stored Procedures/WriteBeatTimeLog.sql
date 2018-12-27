
CREATE PROCEDURE [dbo].[WriteBeatTimeLog]
  (
  @UserID    DUSER_ID,
  @PatientID DPATIENT_ID,
  @StartFt   BIGINT,
  @NumBeats  INT,
  @BeatData  IMAGE,
  @SampleRate SMALLINT
  )
AS
  BEGIN
    INSERT INTO dbo.int_beat_time_log
                (user_id,
                 patient_id,
                 start_ft,
                 num_beats,
                 beat_data,
                 sample_rate)
    VALUES      (@UserID,
                 @PatientID,
                 @StartFt,
                 @Numbeats,
                 @BeatData,
                 @SampleRate)

  END

