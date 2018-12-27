
CREATE PROCEDURE [dbo].[WriteEventData]
  (
  @UserID    DUSER_ID,
  @PatientID DPATIENT_ID,
  @Type      INT,
  @NumEvents INT,
  @EventData IMAGE,
  @SampleRate SMALLINT
  )
AS
  BEGIN
    INSERT INTO dbo.AnalysisEvents
                (user_id,
                 patient_id,
                 type,
                 num_events,
                 sample_rate,
                 event_data)
    VALUES      (@UserID,
                 @PatientID,
                 @Type,
                 @NumEvents,
                 @SampleRate,
                 @EventData)

  END


