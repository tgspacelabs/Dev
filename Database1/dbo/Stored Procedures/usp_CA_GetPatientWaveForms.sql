-- =============================================
-- Author:		SyamB.
-- Create date: 05-20-2014
-- Description:	Retrieves the waveform data for the given list of channels. This is to make Waveform requests from
-- CA-Waveform view to be a single IO call
-- =============================================
CREATE PROCEDURE [dbo].[usp_CA_GetPatientWaveForms]
    (
     @patient_id UNIQUEIDENTIFIER,
     @channelIds [dbo].[StringList] READONLY,
     @start_ft BIGINT,
     @end_ft BIGINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @l_start_ft BIGINT = @start_ft,
        @l_end_ft BIGINT = @end_ft;

    DECLARE @l_start_ut DATETIME = [dbo].[fnFileTimeToDateTime](@l_start_ft),
        @l_end_ut DATETIME = [dbo].[fnFileTimeToDateTime](@l_end_ft),
        @l_patient_id UNIQUEIDENTIFIER = @patient_id;

    SELECT
        [dbo].[fnDateTimeToFileTime]([StartTimeUTC]) AS [start_ft],
        [dbo].[fnDateTimeToFileTime]([EndTimeUTC]) AS [end_ft],
        CAST(NULL AS DATETIME) AS [start_dt],
        CAST(NULL AS DATETIME) AS [end_dt],
        CASE WHEN [Compressed] = 0 THEN NULL
             ELSE 'WCTZLIB'
        END AS [compress_method],
        [Samples] AS [waveform_data],
        [TypeId] AS [channel_id]
    FROM
        [dbo].[WaveformData]
    WHERE
        [TypeId] IN (SELECT
                        [Item]
                     FROM
                        @channelIds)
        AND [TopicSessionId] IN (SELECT
                                    [TopicSessionId]
                                 FROM
                                    [dbo].[v_PatientTopicSessions]
                                 WHERE
                                    [PatientId] = @l_patient_id)
        AND [StartTimeUTC] <= @l_end_ut
        AND [EndTimeUTC] > @l_start_ut
    UNION ALL
    SELECT
        [wfrm].[start_ft],
        [wfrm].[end_ft],
        [wfrm].[start_dt],
        [wfrm].[end_dt],
        [wfrm].[compress_method],
        CAST([wfrm].[waveform_data] AS VARBINARY(MAX)),
        [pc].[channel_type_id] AS [channel_id]
    FROM
        [dbo].[int_waveform] [wfrm] WITH (NOLOCK)
        INNER JOIN [dbo].[int_patient_channel] [pc] ON [wfrm].[patient_channel_id] = [pc].[patient_channel_id]
        INNER JOIN [dbo].[int_patient_monitor] [pm] ON [pc].[patient_monitor_id] = [pm].[patient_monitor_id]
        INNER JOIN [dbo].[int_encounter] [pe] ON [pm].[encounter_id] = [pe].[encounter_id]
    WHERE
        [wfrm].[patient_id] = @l_patient_id
        AND ([pc].[channel_type_id] IN (SELECT
                                            [Item]
                                        FROM
                                            @channelIds))
        AND @l_start_ft < [wfrm].[end_ft]
        AND @l_end_ft >= [wfrm].[start_ft]
    ORDER BY
        [start_ft];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Retrieves the waveform data for the given list of channels.  This is to make Waveform requests from.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_CA_GetPatientWaveForms';

