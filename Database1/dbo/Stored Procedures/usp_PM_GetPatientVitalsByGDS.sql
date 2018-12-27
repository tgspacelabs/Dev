

-------------------------------------------------------

--====================================================================================================================
--=================================================usp_PM_GetPatientVitals==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Retrieves Patient Vital information from the copied ET Vitals data.
-- @gdsCodes: The alarm id associated with the print job
-- @patientId: The patient Id associated with the patient vitals to return
-- @startTimeUTC: The start time in UTC to start grabbing vitals from
-- @endTimeUTC:  The end time in UTC to finish grabbing vitals from
CREATE PROCEDURE [dbo].[usp_PM_GetPatientVitalsByGDS]
    (
     @gdsCodes [dbo].[GdsCodes] READONLY,
     @patientId UNIQUEIDENTIFIER,
     @startTimeUTC DATETIME,
     @endTimeUTC DATETIME
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [Vitals].[GDSCode],
        [Vitals].[Name],
        [Vitals].[Value],
        [Vitals].[ResultTimeUTC]
    FROM
        (SELECT
            [Vitals].[GDSCode],
            [Vitals].[Name],
            [Vitals].[Value],
            [Vitals].[ResultTimeUTC]
         FROM
            [dbo].[int_print_job_et_vitals] [Vitals]
            INNER JOIN (SELECT
                            [GdsCode]
                        FROM
                            @gdsCodes
                       ) [Codes] ON [Codes].[GdsCode] = [Vitals].[GDSCode]
         WHERE
            [Vitals].[PatientId] = @patientId
            AND [Vitals].[ResultTimeUTC] >= @startTimeUTC
            AND [Vitals].[ResultTimeUTC] <= @endTimeUTC
         UNION ALL
         SELECT
            [GdsCode] AS [GDSCode],
            [VitalsData].[Name] AS [Name],
            [Value] AS [Value],
            [TimestampUTC] AS [ResultTimeUTC]
         FROM
            [dbo].[VitalsData]
            INNER JOIN [dbo].[GdsCodeMap] ON [GdsCode] IN (SELECT
                                                                [GdsCode]
                                                            FROM
                                                                @gdsCodes)
                                     AND [GdsCodeMap].[FeedTypeId] = [VitalsData].[FeedTypeId]
                                     AND [GdsCodeMap].[Name] = [VitalsData].[Name]
         WHERE
            [TopicSessionId] IN (SELECT
                                                [Id]
                                            FROM
                                                [dbo].[TopicSessions]
                                            WHERE
                                                [PatientSessionId] IN (SELECT DISTINCT
                                                                        [PatientSessionId]
                                                                     FROM
                                                                        [dbo].[PatientSessionsMap]
                                                                     WHERE
                                                                        [PatientId] = @patientId))
            AND [TimestampUTC] >= @startTimeUTC
            AND [TimestampUTC] <= @endTimeUTC
         UNION ALL
         SELECT
            [GdsCode] AS [GDSCode],
            [LiveData].[Name] AS [Name],
            [Value] AS [Value],
            [TimestampUTC] AS [ResultTimeUTC]
         FROM
            [dbo].[LiveData]
            INNER JOIN [dbo].[GdsCodeMap] ON [GdsCode] IN (SELECT
                                                                [GdsCode]
                                                            FROM
                                                                @gdsCodes)
                                     AND [GdsCodeMap].[FeedTypeId] = [LiveData].[FeedTypeId]
                                     AND [GdsCodeMap].[Name] = [LiveData].[Name]
         WHERE
            [TopicInstanceId] IN (SELECT
                                            [TopicInstanceId]
                                           FROM
                                            [dbo].[TopicSessions]
                                           WHERE
                                            [PatientSessionId] IN (SELECT DISTINCT
                                                                    [PatientSessionId]
                                                                 FROM
                                                                    [dbo].[PatientSessionsMap]
                                                                 WHERE
                                                                    [PatientId] = @patientId)
                                            AND [EndTimeUTC] IS NULL)
            AND [TimestampUTC] >= @startTimeUTC
            AND [TimestampUTC] <= @endTimeUTC
        ) AS [Vitals];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retrieves Patient Vital information from the copied ET Vitals data.  @gdsCodes: The alarm id associated with the print job.  @PatientId: The patient Id associated with the patient vitals to return.  @startTimeUTC: The start time in UTC to start grabbing vitals from.  @endTimeUTC:  The end time in UTC to finish grabbing vitals from.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PM_GetPatientVitalsByGDS';

