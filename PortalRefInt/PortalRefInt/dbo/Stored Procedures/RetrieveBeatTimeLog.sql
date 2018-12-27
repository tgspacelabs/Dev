CREATE PROCEDURE [dbo].[RetrieveBeatTimeLog]
    (
     @UserID [dbo].[DUSER_ID], -- TG - Should be BIGINT
     @PatientId [dbo].[DPATIENT_ID] -- TG - Should be BIGINT
    )
AS
BEGIN
    SELECT
        [user_id],
        [start_ft],
        [num_beats],
        [sample_rate],
        [beat_data]
    FROM
        [dbo].[int_beat_time_log]
    WHERE
        [user_id] = CAST(@UserID AS BIGINT)
        AND [patient_id] = CAST(@PatientId AS BIGINT);
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'RetrieveBeatTimeLog';

