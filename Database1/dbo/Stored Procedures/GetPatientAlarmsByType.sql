CREATE PROCEDURE [dbo].[GetPatientAlarmsByType]
    (
     @patient_id UNIQUEIDENTIFIER,
     @alarm_type INT,
     @start_ft BIGINT,
     @end_ft BIGINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [ia].[alarm_id] AS [ID],
        [ia].[alarm_cd] AS [TITLE],
        [ia].[start_ft] AS [START_FT],
        [ia].[end_ft] AS [END_FT],
        [ia].[start_dt] AS [START_DT],
        [ia].[removed],
        [ia].[alarm_level] AS [PRIORITY]
    FROM
        [dbo].[int_alarm] AS [ia]
        INNER JOIN [dbo].[int_patient_channel] AS [ipc] ON [ia].[patient_channel_id] = [ipc].[patient_channel_id]
        INNER JOIN [dbo].[int_channel_type] AS [ict] ON [ipc].[channel_type_id] = [ict].[channel_type_id]
    WHERE
        [ia].[patient_id] = @patient_id
        AND [ict].[channel_code] = @alarm_type
        AND (@start_ft < [END_FT]
        AND @end_ft >= [START_FT]
        )
        OR (@end_ft >= [START_FT]
        AND [END_FT] IS NULL
        )
    ORDER BY
        [START_FT];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetPatientAlarmsByType';

