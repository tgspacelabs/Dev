

CREATE PROCEDURE [dbo].[GetWaveFormTimes]
    (
     @PatientID DPATIENT_ID,
     @Channel1Code SMALLINT,
     @Channel2Code SMALLINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        MIN([wvfrm].[start_ft]) AS [start_time],
        MAX([wvfrm].[end_ft]) AS [end_time],
        [ct].[channel_code],
        [ct].[channel_type_id]
    FROM
        [dbo].[int_waveform] [wvfrm]
        INNER JOIN [dbo].[int_patient_channel] [pc] ON [wvfrm].[patient_channel_id] = [pc].[patient_channel_id]
        INNER JOIN [dbo].[int_channel_type] [ct] ON [pc].[channel_type_id] = [ct].[channel_type_id]
    WHERE
        ([wvfrm].[patient_id] = @PatientID)
        AND ([ct].[channel_code] = @Channel1Code
        OR [ct].[channel_code] = @Channel2Code
        )
    GROUP BY
        [ct].[channel_code],
        [ct].[channel_type_id]
    UNION ALL
    SELECT
        MIN([wvfrm].[FileTimeStampBeginUTC]) AS [start_time],
        MAX([wvfrm].[FileTimeStampEndUTC]) AS [end_time],
        [ct].[ChannelCode] AS [channel_code],
        [ct].[TypeId] AS [channel_type_id]
    FROM
        [dbo].[v_LegacyWaveform] [wvfrm]
        INNER JOIN [dbo].[v_PatientChannelLegacy] ON [wvfrm].[TypeId] = [v_PatientChannelLegacy].[TypeId]
        INNER JOIN [dbo].[v_LegacyChannelTypes] [ct] ON [v_PatientChannelLegacy].[TypeId] = [ct].[TypeId]
    WHERE
        ([wvfrm].[PatientId] = @PatientID)
        AND ([ct].[ChannelCode] = @Channel1Code
        OR [ct].[ChannelCode] = @Channel2Code
        )
    GROUP BY
        [ct].[ChannelCode],
        [ct].[TypeId]
    ORDER BY
        [channel_code];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetWaveFormTimes';

