CREATE PROCEDURE [dbo].[GetMinMaxPatientTimes]
    (
    @patient_id AS [DPATIENT_ID], -- Should be UNIQUEIDENTIFIER -- TG
    @getAll AS BIT = 1)
AS
BEGIN
    DECLARE @l_patient_id UNIQUEIDENTIFIER = CAST(@patient_id AS UNIQUEIDENTIFIER); -- Remove implicit conversion from queries below

    IF (@getAll = 0)
    BEGIN
        SELECT
            MIN([iw].[start_ft]) AS [START_FT],
            MAX([iw].[end_ft]) AS [END_FT]
        FROM [dbo].[int_patient_channel] AS [ipc]
            INNER JOIN [dbo].[int_waveform] AS [iw]
                ON [ipc].[patient_channel_id] = [iw].[patient_channel_id]
        WHERE [iw].[patient_id] = @l_patient_id;
    END;
    ELSE
    BEGIN
        SELECT
            MIN([ComboWaveform].[START_FT]) AS [START_FT],
            MAX([ComboWaveform].[END_FT]) AS [END_FT]
        FROM (SELECT
                  MIN([START_FT].[FileTime]) AS [START_FT],
                  MAX([END_FT].[FileTime]) AS [END_FT]
              FROM [dbo].[WaveformData] AS [wd]
                  INNER JOIN [dbo].[TopicSessions] AS [ts]
                      ON [wd].[TopicSessionId] = [ts].[Id]
                  CROSS APPLY [dbo].[fntDateTimeToFileTime]([wd].[StartTimeUTC]) AS [START_FT]
                  CROSS APPLY [dbo].[fntDateTimeToFileTime]([wd].[EndTimeUTC]) AS [END_FT]
              WHERE [ts].[PatientSessionId] IN (SELECT [psm].[PatientSessionId]
                                                FROM [dbo].[PatientSessionsMap] AS [psm]
                                                    INNER JOIN (SELECT MAX([psm2].[Sequence]) AS [MaxSeq]
                                                                FROM [dbo].[PatientSessionsMap] AS [psm2]
                                                                GROUP BY [psm2].[PatientSessionId]) AS [PatientSessionMaxSeq]
                                                        ON [psm].[Sequence] = [PatientSessionMaxSeq].[MaxSeq]
                                                WHERE [psm].[PatientId] = @l_patient_id)
              UNION ALL
              SELECT
                  MIN([iw].[start_ft]) AS [START_FT],
                  MAX([iw].[end_ft]) AS [END_FT]
              FROM [dbo].[int_patient_channel] AS [ipc]
                  INNER JOIN [dbo].[int_waveform] AS [iw]
                      ON [ipc].[patient_channel_id] = [iw].[patient_channel_id]
              WHERE [iw].[patient_id] = @l_patient_id) AS [ComboWaveform];
    END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get the minimum and maximum patient (filetime) times from waveform data.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetMinMaxPatientTimes';

