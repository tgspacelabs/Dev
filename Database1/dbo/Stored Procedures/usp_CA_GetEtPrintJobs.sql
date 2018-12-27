

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
    @alarmStartMinUTC DATETIME = NULL,
    @alarmStartMaxUTC DATETIME = NULL,
    @locale VARCHAR(2) = 'en'
AS
BEGIN
    SET NOCOUNT ON;

    SET @alarmStartMinUTC = COALESCE(@alarmStartMinUTC, CONVERT(DATETIME, '1753-01-01 00:00:00', 20)); -- default to minimum date time possible
    SET @alarmStartMaxUTC = COALESCE(@alarmStartMaxUTC, CONVERT(DATETIME, '9999-12-31 23:59:59', 20)); -- default to maximum date time possible

    DECLARE @msPerPageConst FLOAT = 6000.0; -- There are 6 seconds per page. We use ms instead of seconds to overcome inaccuracies in DateDiff due to boundary cross counting.
    DECLARE @msPerSecond INT = 1000;

    DECLARE @tMinusPaddingSeconds INT; -- The number of seconds of waveform/vitals data before and after an alarm that we want to display/capture

    SELECT
        @tMinusPaddingSeconds = [Value]
    FROM
        [dbo].[ApplicationSettings]
    WHERE
        [ApplicationType] = 'Global'
        AND [Key] = 'PrintJobPaddingSeconds';

    IF @locale IS NULL
        OR @locale NOT IN ('de', 'en', 'es', 'fr', 'it', 'nl', 'pl', 'zh', 'cs', 'pt')
        SET @locale = 'en';

	-- Note: There are two types of alarms, limit alarms and general alarms. The 'description' for a general alarm is just the Alarms.StrMessage. For limit alarms the description is formatted in a 
	-- special way to include information relating to the limits and the actual values... this 'special' format was copied from other stored procedures to be consistent.

    SELECT
        [Alarms].[AlarmId],
        ISNULL(ISNULL([ResMessage].[Value], '') + '  ' + REPLACE(ISNULL([ResValue].[Value], ''), '{0}', [Alarms].[ViolatingValue]) + '  ' + REPLACE(ISNULL([ResLimit].[Value], ''), '{0}', [Alarms].[SettingViolated]), [ResMessage].[Value]) AS [Description],
        [Alarms].[AlarmStartTimeUTC],
        [NumPages] = CEILING((DATEDIFF(ms, [Alarms].[AlarmStartTimeUTC], CASE WHEN [Alarms].[AlarmEndTimeUTC] IS NULL THEN GETUTCDATE()
                                                                              ELSE [Alarms].[AlarmEndTimeUTC]
                                                                         END) + (2 * (@tMinusPaddingSeconds * @msPerSecond))) / @msPerPageConst)
    FROM
        [dbo].[int_print_job_et_alarm] AS [Alarms]
        LEFT JOIN [dbo].[ResourceStrings] [ResMessage] ON [ResMessage].[Name] = [Alarms].[StrMessage]
                                                          AND [ResMessage].[Locale] = @locale
        LEFT JOIN [dbo].[ResourceStrings] [ResLimit] ON [ResLimit].[Name] = [Alarms].[StrLimitFormat]
                                                        AND [ResLimit].[Locale] = @locale
        LEFT JOIN [dbo].[ResourceStrings] [ResValue] ON [ResValue].[Name] = [Alarms].[StrValueFormat]
                                                        AND [ResValue].[Locale] = @locale
    WHERE
        [Alarms].[PatientId] = @patientId
        AND [Alarms].[AlarmStartTimeUTC] >= @alarmStartMinUTC
        AND [Alarms].[AlarmStartTimeUTC] <= @alarmStartMaxUTC
    ORDER BY
        [Alarms].[AlarmStartTimeUTC] DESC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Returns the ET print alarm job information.  If an unknown or invalid locale is specified, English will be used.  @PatientId: The unique patient identifier to get print jobs associated with.  @alarmStartMinUTC: The minimum/earliest alarm start date time to retrieve (for retrieving alarms in a window/range) in UTC.  @alarmStartMaxUTC: The maximum/lastest alarm start date time to retrieve (for retrieving alarms in a window/range) in UTC.  @locale: The two digit locale to translate the descriptions string into.  Returns: [AlarmId]: The unique alarm identifier associated with the print job, [Description]: A localized and formatted alarm description, [AlarmStartTimeUTC]: The date/time that the alarm was created/started in UTC, [NumPages]: The estimated number of pages of this et print alarm print report.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_CA_GetEtPrintJobs';

