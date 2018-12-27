


CREATE PROCEDURE [dbo].[GetMinMaxPatientTimesFromVitals]
    (
     @patient_id AS [DPATIENT_ID],
     @getAll AS BIT = 1
    )
AS
BEGIN
    SET NOCOUNT ON;

    IF @getAll = 0
    BEGIN   
        SELECT
            MIN([result_ft]) AS [START_FT],
            MAX([result_ft]) AS [END_FT]
        FROM
            [dbo].[int_result]
        WHERE
            [patient_id] = @patient_id;
    END;
    ELSE
    BEGIN
        SELECT
            MIN([ComboWaveform].[START_FT]) AS [START_FT],
            MAX([ComboWaveform].[END_FT]) AS [END_FT]
        FROM
            (SELECT
                [dbo].[fnDateTimeToFileTime](MIN([TimestampUTC])) AS [START_FT],
                [dbo].[fnDateTimeToFileTime](MAX([TimestampUTC])) AS [END_FT]
             FROM
                [dbo].[VitalsData]
             WHERE
                [TopicSessionId] IN (SELECT
                                        [TopicSessionId]
                                     FROM
                                        [dbo].[v_PatientTopicSessions]
                                     WHERE
                                        [PatientId] = @patient_id)
             UNION ALL
             SELECT
                MIN([result_ft]) AS [START_FT],
                MAX([result_ft]) AS [END_FT]
             FROM
                [dbo].[int_result]
             WHERE
                [patient_id] = @patient_id
            ) AS [ComboWaveform];
    END;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetMinMaxPatientTimesFromVitals';

