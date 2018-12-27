

--====================================================================================================================
--=================================================usp_PM_GetAlarmData==================================
-----------------------------------------------------------------------------------------------
-- =======================================================================
-- Purpose: Retreives alarm data for a given alarm id
-- @alarmId: The alarm id associated with the print job
-- @locale: The two digit locale to translate the descriptions string into.
CREATE PROCEDURE [dbo].[usp_PM_GetAlarmData]
    @alarmId UNIQUEIDENTIFIER,
    @locale VARCHAR(2) = 'en'
AS
BEGIN
    SET NOCOUNT ON;

    IF @alarmId IS NULL
        RAISERROR(14043, -1, -1, '@alarmId', 'usp_PM_GetAlarmData');
		
    IF @locale IS NULL
        OR @locale NOT IN ('de', 'en', 'es', 'fr', 'it', 'nl', 'pl', 'zh', 'cs', 'pt')
        SET @locale = 'en';

    DECLARE @paddingSeconds INT; -- The number of seconds of waveform/vitals data before and after an alarm that we want to display/capture

    SELECT
        @paddingSeconds = [Value]
    FROM
        [dbo].[ApplicationSettings]
    WHERE
        [ApplicationType] = 'Global'
        AND [Key] = 'PrintJobPaddingSeconds';

    IF @paddingSeconds IS NULL
        RAISERROR(N'Global setting "%s" from the ApplicationSettings table was null or missing', 13, 1, N'PrintJobPaddingSeconds');

    BEGIN
        SELECT
            [Alarms].[AlarmId] AS [Id],
            [Alarms].[PatientId],
            ISNULL(ISNULL([ResMessage].[Value], '') + '  ' + REPLACE(ISNULL([ResValue].[Value], ''), '{0}', [Alarms].[ViolatingValue]) + '  ' + REPLACE(ISNULL([ResLimit].[Value], ''), '{0}', [Alarms].[SettingViolated]), [ResMessage].[Value]) AS [Title],
            DATEADD(s, -@paddingSeconds, [Alarms].[AlarmStartTimeUTC]) AS [ReportStartTimeUTC],
            DATEADD(s, @paddingSeconds, [Alarms].[AlarmEndTimeUTC]) AS [ReportEndTimeUTC],
            ISNULL([ResLabel].[Value], '') AS [TitleLabel],
            [Alarms].[FirstName],
            [Alarms].[LastName],
            [Alarms].[FullName],
            [Alarms].[ID1],
            [Alarms].[ID2],
            [Alarms].[DOB],
            [Alarms].[FacilityName],
            [Alarms].[UnitName],
            [Alarms].[MonitorName]
        FROM
            [dbo].[int_print_job_et_alarm] [Alarms]
            LEFT JOIN [dbo].[ResourceStrings] [ResMessage] ON [ResMessage].[Name] = [Alarms].[StrMessage]
                                                        AND [ResMessage].[Locale] = @locale
            LEFT JOIN [dbo].[ResourceStrings] [ResLimit] ON [ResLimit].[Name] = [Alarms].[StrLimitFormat]
                                                      AND [ResLimit].[Locale] = @locale
            LEFT JOIN [dbo].[ResourceStrings] [ResValue] ON [ResValue].[Name] = [Alarms].[StrValueFormat]
                                                      AND [ResValue].[Locale] = @locale
            LEFT JOIN [dbo].[ResourceStrings] [ResLabel] ON [ResLabel].[Name] = [Alarms].[StrTitleLabel]
                                                      AND [ResLabel].[Locale] = @locale
        WHERE
            [Alarms].[AlarmId] = @alarmId;
    END;		
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Purpose: Retreives alarm data for a given alarm id.  @alarmId: The alarm id associated with the print job.  @locale: The two digit locale to translate the descriptions string into.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_PM_GetAlarmData';

