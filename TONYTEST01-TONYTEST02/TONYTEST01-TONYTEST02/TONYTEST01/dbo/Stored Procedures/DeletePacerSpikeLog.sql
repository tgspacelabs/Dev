
CREATE PROCEDURE [dbo].[DeletePacerSpikeLog]
  (
  @UserID    DUSER_ID,
  @PatientID DPATIENT_ID,
  @SampleRate SMALLINT
  )
AS
  BEGIN
    DELETE dbo.PacerSpikeLog
    WHERE  ( user_id = @UserID AND patient_id = @PatientID AND sample_rate = @SampleRate )
  END

