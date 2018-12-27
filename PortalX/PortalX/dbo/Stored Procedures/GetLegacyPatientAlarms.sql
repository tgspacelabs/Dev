CREATE PROCEDURE [dbo].[GetLegacyPatientAlarms]
    (
    @patient_id UNIQUEIDENTIFIER,
    @start_ft BIGINT,
    @end_ft BIGINT,
    @locale VARCHAR(7) = 'en')
AS
BEGIN
    SELECT
        [ia].[alarm_id] AS [Id],
        [ict].[channel_code] AS [TYPE],
        ISNULL([ia].[alarm_cd], '') AS [TypeString],
        ISNULL([ia].[alarm_cd], '') AS [TITLE],
        [ia].[start_ft] AS [start_ft],
        [ia].[end_ft] AS [end_ft],
        [ia].[start_dt] AS [START_DT],
        [ia].[removed] AS [Removed],
        [ia].[alarm_level] AS [priority],
        CAST('' AS NVARCHAR(250)) AS [Label]
    FROM [dbo].[int_alarm] AS [ia]
        INNER JOIN [dbo].[int_patient_channel] AS [ipc]
            ON [ia].[patient_channel_id] = [ipc].[patient_channel_id]
        INNER JOIN [dbo].[int_channel_type] AS [ict]
            ON [ipc].[channel_type_id] = [ict].[channel_type_id]
    WHERE [ia].[patient_id] = @patient_id
          AND [ia].[alarm_level] > 0
          AND (@start_ft < [end_ft]
               OR [end_ft] IS NULL)
    ORDER BY [start_ft] DESC;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get a list of alarms from a non enhanced tele patient', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetLegacyPatientAlarms';

