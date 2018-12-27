
CREATE PROCEDURE [dbo].[GetMinMaxPatientTimes]
    (
     @patient_id AS [DPATIENT_ID],
     @getAll AS BIT = 1
    )
AS
BEGIN
    --SET NOCOUNT ON;

    IF (@getAll = 0)
    BEGIN   	
        SELECT
            MIN([iw].[start_ft]) AS [START_FT],
            MAX([iw].[end_ft]) AS [END_FT]
        FROM
            [dbo].[int_waveform] AS [iw]
        WHERE
            [iw].[patient_id] = @patient_id;
    END;
    ELSE
    BEGIN 
        SELECT
            MIN([ComboWaveform].[START_FT]) AS [START_FT],
            MAX([ComboWaveform].[END_FT]) AS [END_FT]
        FROM
            (SELECT
                [dbo].[fnDateTimeToFileTime](MIN([wd].[StartTimeUTC])) AS [START_FT],
                [dbo].[fnDateTimeToFileTime](MAX([wd].[EndTimeUTC])) AS [END_FT]
             FROM
                [dbo].[WaveformData] AS [wd]
             WHERE
                [wd].[TopicSessionId] IN (SELECT
                                        [ts].[Id]
                                     FROM
                                        [dbo].[TopicSessions] AS [ts]
                                     WHERE
                                        [ts].[PatientSessionId] IN (SELECT DISTINCT
                                                                [PatientSessionId]
                                                               FROM
                                                                [dbo].[PatientSessionsMap]
                                                               WHERE
                                                                [PatientId] = @patient_id))
             UNION ALL
             SELECT
                MIN([iw].[start_ft]) AS [START_FT],
                MAX([iw].[end_ft]) AS [END_FT]
             FROM
                [dbo].[int_waveform] AS [iw]
             WHERE
                [iw].[patient_id] = @patient_id
            ) AS [ComboWaveform];
    END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetMinMaxPatientTimes';

