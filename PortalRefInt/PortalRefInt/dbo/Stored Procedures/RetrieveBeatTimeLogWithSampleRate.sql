CREATE PROCEDURE [dbo].[RetrieveBeatTimeLogWithSampleRate]
    (
     @UserID [dbo].[DUSER_ID], -- TG - Should be BIGINT
     @PatientId [dbo].[DPATIENT_ID], -- TG - Should be BIGINT
     @SampleRate SMALLINT
    )
AS
BEGIN
    SELECT
        [user_id],
        [patient_id],
        [start_ft],
        [num_beats],
        [sample_rate],
        [beat_data]
    FROM
        [dbo].[int_beat_time_log]
    WHERE
        [user_id] = CAST(@UserID AS BIGINT)
        AND [patient_id] = CAST(@PatientId AS BIGINT)
        AND [sample_rate] = @SampleRate;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'RetrieveBeatTimeLogWithSampleRate';

