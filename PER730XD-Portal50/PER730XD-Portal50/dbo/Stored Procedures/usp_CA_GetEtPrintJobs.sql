
--====================================================================================================================
--=================================================usp_CA_GetEtPrintJobs==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Returns the ET print alarm job information. If an unknown or invalid locale is specified, English will be used.
--
--
-- @patientId: The unique patient identifier to get print jobs associated with.
-- @alarmStartMinUTC: The minimum/earliest alarm start date time to retrieve (for retrieving alarms in a window/range) in UTC.
-- @alarmStartMaxUTC: The maximum/lastest alarm start date time to retrieve (for retrieving alarms in a window/range) in UTC.
-- @locale: The two digit locale to translate the descriptions string into.
--
-- Returns:
-- [AlarmId]: The unique alarm identifier associated with the print job.
-- [Description]: A localized and formatted alarm description.
-- [AlarmStartTimeUTC]: The date/time that the alarm was created/started in UTC.
-- [NumPages]: The estimated number of pages of this et print alarm print report.
-- =======================================================================
CREATE PROCEDURE [dbo].[usp_CA_GetEtPrintJobs]
    @patientId UNIQUEIDENTIFIER,
    @alarmStartMinUTC datetime = NULL, 
    @alarmStartMaxUTC datetime = NULL, 
    @locale varchar(2)='en'
AS

BEGIN 
     SET @alarmStartMinUTC = COALESCE(@alarmStartMinUTC, CONVERT(DATETIME, '1753-01-01 00:00:00', 20)) -- default to minimum date time possible
     SET @alarmStartMaxUTC = COALESCE(@alarmStartMaxUTC, CONVERT(DATETIME, '9999-12-31 23:59:59', 20)) -- default to maximum date time possible

    DECLARE @msPerPageConst float = 6000.0 -- There are 6 seconds per page. We use ms instead of seconds to overcome inaccuracies in DateDiff due to boundary cross counting.
    DECLARE @msPerSecond int = 1000

    DECLARE @tMinusPaddingSeconds int -- The number of seconds of waveform/vitals data before and after an alarm that we want to display/capture

    SELECT @tMinusPaddingSeconds = [Value]
    FROM ApplicationSettings
    WHERE [ApplicationType] = 'Global' AND [Key] = 'PrintJobPaddingSeconds'

    IF @locale IS NULL OR @locale NOT IN ('de', 'en', 'es', 'fr', 'it', 'nl', 'pl', 'zh', 'cs', 'pt')
        SET @locale = 'en'

    -- Note: There are two types of alarms, limit alarms and general alarms. The 'description' for a general alarm is just the Alarms.StrMessage. For limit alarms the description is formatted in a 
    -- special way to include information relating to the limits and the actual values... this 'special' format was copied from other stored procedures to be consistent.

      SELECT     [AlarmId],
               ISNULL(ISNULL(ResMessage.Value, '') + '  ' + REPLACE(ISNULL(ResValue.Value,''), '{0}', [Alarms].ViolatingValue) + '  ' + replace(ISNULL(ResLimit.Value,''), '{0}', [Alarms].SettingViolated), ResMessage.Value)  AS Description,
               [AlarmStartTimeUTC],
               [NumPages] =  CEILING((DATEDIFF(ms, AlarmStartTimeUTC, CASE WHEN AlarmEndTimeUTC IS NULL THEN GETUTCDATE() ELSE AlarmEndTimeUTC END) + (2 * (@tMinusPaddingSeconds * @msPerSecond)))/@msPerPageConst)
    FROM [dbo].[int_print_job_et_alarm] as Alarms
            LEFT JOIN dbo.ResourceStrings ResMessage ON ResMessage.Name = [Alarms].StrMessage and ResMessage.Locale=@locale
        LEFT JOIN dbo.ResourceStrings ResLimit ON ResLimit.Name = [Alarms].StrLimitFormat and ResLimit.Locale=@locale
        LEFT JOIN dbo.ResourceStrings ResValue ON ResValue.Name = [Alarms].StrValueFormat and ResValue.Locale=@locale
    WHERE [PatientId] = @patientId
          AND Alarms.AlarmStartTimeUTC >= @alarmStartMinUTC
          AND Alarms.AlarmStartTimeUTC <= @alarmStartMaxUTC
    ORDER BY [AlarmStartTimeUTC] DESC
END

