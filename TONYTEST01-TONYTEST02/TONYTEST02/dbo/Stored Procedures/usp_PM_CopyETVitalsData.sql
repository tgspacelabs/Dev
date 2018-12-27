

--====================================================================================================================
--=================================================usp_PM_CopyETVitalsData==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Copies vitals data related to ET Alarms for printing and reprinting. Used by the ICS_PrintJobDataCopier SqlAgentJob.
-- =======================================================================
CREATE PROCEDURE [dbo].[usp_PM_CopyETVitalsData]
AS
BEGIN 
SET NOCOUNT ON;

DECLARE @preAlarmDataMinutes int
SET @preAlarmDataMinutes = 15 -- The number of minutes to grab vitals data before the start of the alarm... using this instead of tMinusPaddingSeconds for preAlarm in order to match what Clinical Access Alarms Tab does.

DECLARE @tMinusPaddingSeconds int -- The number of seconds of waveform/vitals data after an alarm that we want to display/capture

SELECT @tMinusPaddingSeconds = [Value]
FROM ApplicationSettings
WHERE [ApplicationType] = 'Global' AND [Key] = 'PrintJobPaddingSeconds'

IF @tMinusPaddingSeconds IS NULL
		RAISERROR(N'Global setting "%s" from the ApplicationSettings table was null or missing', 13, 1, N'PrintJobPaddingSeconds')

MERGE dbo.int_print_job_et_vitals AS Target
USING 
(
SELECT DISTINCT
              [PatientId],
              [VitalsData].[TopicSessionId],
              GdsCode AS [GDSCode],
              [VitalsData].Name,
              Value AS [Value],
              TimeStampUTC AS [ResultTimeUTC]
       FROM
              VitalsData
			        INNER JOIN GdsCodeMap ON GdsCodeMap.FeedTypeId = [VitalsData].[FeedTypeId] AND GdsCodeMap.[Name] = [VitalsData].[Name]
					INNER JOIN TopicSessions on TopicSessions.Id = VitalsData.TopicSessionId
                    INNER JOIN int_print_job_et_alarm on int_print_job_et_alarm.DeviceSessionId = TopicSessions.DeviceSessionId

      WHERE VitalsData.TimestampUTC >= DATEADD(MINUTE, -@preAlarmDataMinutes, int_print_job_et_alarm.AlarmStartTimeUTC)
      AND VitalsData.TimestampUTC <= DATEADD(SECOND, @tMinusPaddingSeconds, int_print_job_et_alarm.AlarmEndTimeUTC) 

) AS Source
ON Target.TopicSessionId = Source.TopicSessionId
	AND Target.GDSCode = Source.GDSCode
	AND Target.ResultTimeUTC = Source.ResultTimeUTC 
WHEN NOT MATCHED THEN 
	INSERT(
		Id,
		PatientId,
		TopicSessionId,
		GDSCode,
		Name,
		Value,
		ResultTimeUTC
	)
	VALUES(
		NEWID(),
		Source.PatientId,
		Source.TopicSessionId,
		Source.GDSCode,
		Source.Name,
		Source.Value,
		Source.ResultTimeUTC
	);
END

