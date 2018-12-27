CREATE PROCEDURE [dbo].[GetLegacyPatientAlarms]
    (
     @patient_id UNIQUEIDENTIFIER,
     @start_ft BIGINT,
     @end_ft BIGINT,
     @locale VARCHAR(7) = 'en'
    )
AS
BEGIN 
    SET NOCOUNT ON;

    SELECT
        [Id] = [alarm_id],
        [TYPE] = [channel_code],
        [TypeString] = ISNULL([alarm_cd], N''),
        [TITLE] = ISNULL([alarm_cd], N''),
        [START_FT] = [start_ft],
        [END_FT] = [end_ft],
        [START_DT] = [start_dt],
        [Removed] = [removed],
        [PRIORITY] = [alarm_level],
        [Label] = CAST(N'' AS NVARCHAR(250))
    FROM
        [dbo].[int_alarm]
        INNER JOIN [dbo].[int_patient_channel] ON [int_alarm].[patient_channel_id] = [int_patient_channel].[patient_channel_id]
        INNER JOIN [dbo].[int_channel_type] ON [int_patient_channel].[channel_type_id] = [int_channel_type].[channel_type_id]
    WHERE
        [int_alarm].[patient_id] = @patient_id
        AND [alarm_level] > 0
        AND (@start_ft < [END_FT]
        OR [END_FT] IS NULL
        )
    ORDER BY
        [START_FT];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetLegacyPatientAlarms';

