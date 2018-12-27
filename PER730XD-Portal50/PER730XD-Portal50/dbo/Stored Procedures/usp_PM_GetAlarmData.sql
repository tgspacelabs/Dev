
--====================================================================================================================
--=================================================usp_PM_GetAlarmData==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Retreives alarm data for a given alarm id
-- @alarmId: The alarm id associated with the print job
-- @locale: The two digit locale to translate the descriptions string into.
CREATE PROCEDURE [dbo].[usp_PM_GetAlarmData]
    @alarmId UNIQUEIDENTIFIER,
    @locale varchar(2)='en'
AS

BEGIN
    IF @alarmId IS NULL
        RAISERROR(14043, -1, -1, '@alarmId', 'usp_PM_GetAlarmData')
        
    IF @locale IS NULL OR @locale NOT IN ('de', 'en', 'es', 'fr', 'it', 'nl', 'pl', 'zh', 'cs', 'pt')
        SET @locale = 'en'

    DECLARE @paddingSeconds int -- The number of seconds of waveform/vitals data before and after an alarm that we want to display/capture

SELECT @paddingSeconds = [Value]
FROM ApplicationSettings
WHERE [ApplicationType] = 'Global' AND [Key] = 'PrintJobPaddingSeconds'

IF @paddingSeconds IS NULL
        RAISERROR(N'Global setting "%s" from the ApplicationSettings table was null or missing', 13, 1, N'PrintJobPaddingSeconds')

    BEGIN
        SELECT 
            [Alarms].[AlarmId] AS [Id]
            , [Alarms].[PatientId]
            , ISNULL(ISNULL(ResMessage.Value, '') + '  ' + REPLACE(ISNULL(ResValue.Value,''), '{0}', [Alarms].ViolatingValue) + '  ' + replace(ISNULL(ResLimit.Value,''), '{0}', [Alarms].SettingViolated), ResMessage.Value) AS [Title]
            , DATEADD(s, -@paddingSeconds, [Alarms].AlarmStartTimeUTC) as ReportStartTimeUTC
            , DATEADD(s, @paddingSeconds, [Alarms].AlarmEndTimeUTC) as ReportEndTimeUTC
            , ISNULL(ResLabel.Value, '') as TitleLabel
            , [Alarms].FirstName
            , [Alarms].LastName
            , [Alarms].FullName
            , [Alarms].ID1
            , [Alarms].ID2
            , [Alarms].DOB
            , [Alarms].FacilityName
            , [Alarms].UnitName
            , [Alarms].MonitorName
        FROM 
        [dbo].[int_print_job_et_alarm] [Alarms]
            LEFT JOIN dbo.ResourceStrings ResMessage ON ResMessage.Name = [Alarms].StrMessage and ResMessage.Locale=@locale
            LEFT JOIN dbo.ResourceStrings ResLimit ON ResLimit.Name = [Alarms].StrLimitFormat and ResLimit.Locale=@locale
            LEFT JOIN dbo.ResourceStrings ResValue ON ResValue.Name = [Alarms].StrValueFormat and ResValue.Locale=@locale
            LEFT JOIN dbo.ResourceStrings ResLabel ON ResLabel.Name = [Alarms].StrTitleLabel and ResLabel.Locale=@locale
                
        WHERE 
            AlarmId = @alarmId
    END        
END

