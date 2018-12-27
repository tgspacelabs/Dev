


CREATE PROCEDURE [dbo].[GetPatientStartftFromVitals]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        MIN([START_FT].[START_FT]) AS [START_FT]
    FROM
        (SELECT
            MIN([result_ft]) AS [START_FT]
         FROM
            [dbo].[int_result]
         WHERE
            ([patient_id] = @patient_id)
         UNION ALL
         SELECT
            [dbo].[fnDateTimeToFileTime](MIN([TimestampUTC])) AS [START_FT]
         FROM
            [dbo].[VitalsData]
         WHERE
            [TopicSessionId] IN (SELECT
                                    [TopicSessionId]
                                 FROM
                                    [dbo].[v_PatientTopicSessions]
                                 WHERE
                                    [PatientId] = @patient_id)
        ) AS [START_FT];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientStartftFromVitals';

