

/*To get the waveforms for the Alarm in CEI*/
CREATE PROCEDURE [dbo].[usp_CEI_GetAlarmWaveform]
    (
     @patientId UNIQUEIDENTIFIER,
     @channeltypeId UNIQUEIDENTIFIER,
     @startDateTimeUTC DATETIME,
     @endDateTimeUTC DATETIME
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [StartTimeUTC] AS [START_DT_UTC],
        [EndTimeUTC] AS [END_DT_UTC],
        [Samples] AS [WAVEFORM_DATA]
    FROM
        [dbo].[WaveformLiveData]
    WHERE
        [TopicInstanceId] IN (SELECT
                                [TopicInstanceId]
                              FROM
                                [dbo].[v_PatientTopicSessions]
                                INNER JOIN [dbo].[TopicSessions] ON [Id] = [TopicSessionId]
                              WHERE
                                [PatientId] = @patientId)
        AND [TypeId] = @channeltypeId
        AND [StartTimeUTC] <= @endDateTimeUTC
        AND @startDateTimeUTC <= [EndTimeUTC]
    ORDER BY
        [StartTimeUTC] ASC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get the waveforms for the Alarm in CEI.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_CEI_GetAlarmWaveform';

