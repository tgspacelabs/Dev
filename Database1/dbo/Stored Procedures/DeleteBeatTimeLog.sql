

CREATE PROCEDURE [dbo].[DeleteBeatTimeLog]
    (
     @UserID DUSER_ID,
     @PatientID DPATIENT_ID,
     @SampleRate SMALLINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DELETE
        [dbo].[int_beat_time_log]
    WHERE
        [user_id] = @UserID
        AND [patient_id] = @PatientID
        AND [sample_rate] = @SampleRate;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'DeleteBeatTimeLog';

