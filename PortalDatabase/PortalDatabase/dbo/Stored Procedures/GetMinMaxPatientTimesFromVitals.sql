CREATE PROCEDURE [dbo].[GetMinMaxPatientTimesFromVitals]
    (
     @patient_id [dbo].[DPATIENT_ID], -- TG - Should be UNIQUEIDENTIFIER
     @getAll BIT = 1
    )
AS
BEGIN
    IF (@getAll = 0)
    BEGIN   
        SELECT
            MIN([ir].[result_ft]) AS [start_ft],
            MAX([ir].[result_ft]) AS [end_ft]
        FROM
            [dbo].[int_result] AS [ir]
        WHERE
            [ir].[patient_id] = CAST(@patient_id AS UNIQUEIDENTIFIER);
    END;
    ELSE
    BEGIN
        SELECT
            MIN([ComboWaveform].[start_ft]) AS [start_ft],
            MAX([ComboWaveform].[end_ft]) AS [end_ft]
        FROM
            (SELECT
                [dbo].[fnDateTimeToFileTime](MIN([vd].[TimestampUTC])) AS [start_ft],
                [dbo].[fnDateTimeToFileTime](MAX([vd].[TimestampUTC])) AS [end_ft]
             FROM
                [dbo].[VitalsData] AS [vd]
             WHERE
                [TopicSessionId] IN (SELECT
                                        [vpts].[TopicSessionId]
                                     FROM
                                        [dbo].[v_PatientTopicSessions] AS [vpts]
                                     WHERE
                                        [vpts].[PatientId] = CAST(@patient_id AS UNIQUEIDENTIFIER))
             UNION ALL
             SELECT
                MIN([RowNumber].[result_ft]) AS [start_ft],
                MAX([RowNumber].[result_ft]) AS [end_ft]
             FROM
                [dbo].[int_result] AS [RowNumber]
             WHERE
                [RowNumber].[patient_id] = CAST(@patient_id AS UNIQUEIDENTIFIER)
            ) AS [ComboWaveform];
    END;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetMinMaxPatientTimesFromVitals';

