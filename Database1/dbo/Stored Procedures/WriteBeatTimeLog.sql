

CREATE PROCEDURE [dbo].[WriteBeatTimeLog]
    (
     @UserID DUSER_ID,
     @PatientID DPATIENT_ID,
     @StartFt BIGINT,
     @NumBeats INT,
     @BeatData IMAGE,
     @SampleRate SMALLINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[int_beat_time_log]
            ([user_id],
             [patient_id],
             [start_ft],
             [num_beats],
             [beat_data],
             [sample_rate]
            )
    VALUES
            (@UserID,
             @PatientID,
             @StartFt,
             @NumBeats,
             @BeatData,
             @SampleRate
            );

END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'WriteBeatTimeLog';

