CREATE PROCEDURE [dbo].[usp_CA_GetLegacyPatientWaveForms]
    (
     @patient_id UNIQUEIDENTIFIER,
     @channelIds [dbo].[StringList] READONLY,
     @start_ft BIGINT,
     @end_ft BIGINT
    )
AS
BEGIN
    SELECT
        [wfrm].[start_ft],
        [wfrm].[end_ft],
        [wfrm].[start_dt],
        [wfrm].[end_dt],
        [wfrm].[compress_method],
        CAST([wfrm].[waveform_data] AS VARBINARY(MAX)) AS [waveform_data],
        [pc].[channel_type_id] AS [channel_id]
    FROM
        [dbo].[int_waveform] AS [wfrm] WITH (NOLOCK)
        INNER JOIN [dbo].[int_patient_channel] AS [pc] ON [wfrm].[patient_channel_id] = [pc].[patient_channel_id]
        INNER JOIN [dbo].[int_patient_monitor] AS [pm] ON [pc].[patient_monitor_id] = [pm].[patient_monitor_id]
        INNER JOIN [dbo].[int_encounter] AS [pe] ON [pm].[encounter_id] = [pe].[encounter_id]
    WHERE
        ([wfrm].[patient_id] = @patient_id)
        AND ([pc].[channel_type_id] IN (SELECT
                                        [Item]
                                    FROM
                                        @channelIds))
        AND (@start_ft < [wfrm].[end_ft])
        AND (@end_ft >= [wfrm].[start_ft])
    ORDER BY
        [start_ft];
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_CA_GetLegacyPatientWaveForms';

