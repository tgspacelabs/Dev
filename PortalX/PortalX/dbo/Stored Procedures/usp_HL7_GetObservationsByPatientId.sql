CREATE PROCEDURE [dbo].[usp_HL7_GetObservationsByPatientId]
    (
    @patient_id UNIQUEIDENTIFIER,
    @StartTime DATETIME,
    @EndTime DATETIME,
    @StartTimeUtc DATETIME,
    @EndTimeUtc DATETIME)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DISTINCT
           [Code].[code_id] AS [CodeId],
           [Code].[code] AS [Code],
           [Code].[short_dsc] AS [Descr],
           [Code].[int_keystone_cd] AS [Units],
           [Result].[result_value] AS [ResultValue],
           [Result].[value_type_cd] AS [ValueTypeCd],
           [Result].[result_dt] AS [ResultTime]
    FROM [dbo].[int_result] AS [Result]
        INNER JOIN [dbo].[int_misc_code] AS [Code]
            ON [Result].[test_cid] = [Code].[code_id]
    WHERE ([Result].[patient_id] = @patient_id)
          AND ([Result].[result_dt] BETWEEN @StartTime AND @EndTime)
          AND [Result].[result_value] IS NOT NULL

    UNION ALL

    SELECT
        [gcm].[CodeId],
        [gcm].[GdsCode] AS [Code],
        [gcm].[Description] AS [Descr],
        [gcm].[Units],
        [vd].[Value] AS [ResultValue],
        N'' AS [ValueTypeCd],
        NULL AS [ResultStatus],
        NULL AS [Probability],
        NULL AS [ReferenceRange],
        NULL AS [AbnormalNatureCd],
        NULL AS [AbnormalCd],
        [ResultTime].[LocalDateTime] AS [ResultTime]
    FROM [dbo].[VitalsData] AS [vd]
        INNER JOIN [dbo].[GdsCodeMap] AS [gcm]
            ON [gcm].[FeedTypeId] = [vd].[FeedTypeId]
               AND [gcm].[Name] = [vd].[Name]
        INNER JOIN [dbo].[v_PatientTopicSessions] AS [vpts]
            ON [vd].[TopicSessionId] = [vpts].[TopicSessionId]
        CROSS APPLY [dbo].[fntUtcDateTimeToLocalTime]([vd].[TimestampUTC]) AS [ResultTime]
    WHERE [vpts].[PatientId] = @patient_id
          AND [vd].[TimestampUTC] BETWEEN @StartTimeUtc AND @EndTimeUtc
    ORDER BY [Code] ASC,
             [ResultTime] ASC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retreive the patient observations by patient id.  @PatientId is mandatory.  If @StartTime and @EndTime are passed it will return the observations between the given time span', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_HL7_GetObservationsByPatientId';

