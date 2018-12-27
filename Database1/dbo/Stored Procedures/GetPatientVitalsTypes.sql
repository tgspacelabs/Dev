
CREATE PROCEDURE [dbo].[GetPatientVitalsTypes]
    (
     @patient_id UNIQUEIDENTIFIER
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [Code].[code_id] AS [TYPE],
        [Code].[code] AS [CODE],
        [Code].[int_keystone_cd] AS [UNITS]
    FROM
        [dbo].[int_misc_code] [Code]
        INNER JOIN (SELECT DISTINCT
                        [test_cid]
                    FROM
                        [dbo].[int_result]
                    WHERE
                        [patient_id] = @patient_id
                   ) [result_cid] ON [result_cid].[test_cid] = [Code].[code_id]
    UNION ALL
    SELECT
        [CodeId] AS [TYPE],
        [GdsCode] AS [CODE],
        [Units] AS [UNITS]
    FROM
        [dbo].[GdsCodeMap]
        INNER JOIN (SELECT DISTINCT
                        [Name],
                        [FeedTypeId]
                    FROM
                        [dbo].[VitalsData]
                        INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id] = [TopicSessionId]
                        INNER JOIN [dbo].[PatientSessionsMap] ON [PatientSessionsMap].[PatientSessionId] = [TopicSessions].[PatientSessionId]
                    WHERE
                        [PatientId] = @patient_id
                   ) [VitalTypes] ON [GdsCodeMap].[FeedTypeId] = [VitalTypes].[FeedTypeId]
                                     AND [GdsCodeMap].[Name] = [VitalTypes].[Name];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientVitalsTypes';

