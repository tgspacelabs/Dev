
CREATE PROCEDURE [dbo].[RetrievePacerSpikeLog]
  (
  @UserID    DUSER_ID,
  @PatientID DPATIENT_ID,
  @SampleRate SMALLINT
  )
AS
  BEGIN
    SELECT user_id,
           patient_id,
           sample_rate,
           start_ft,
           num_spikes,
           spike_data
    FROM   dbo.PacerSpikeLog
    WHERE  ( user_id = @UserID AND patient_id = @PatientID AND sample_rate = @SampleRate )
  END

