CREATE PROCEDURE [dbo].[GetWaveFormTimes]
    (
     @PatientId [dbo].[DPATIENT_ID], -- TG - Should be UNIQUEIDENTIFIER
     @Channel1Code SMALLINT,
     @Channel2Code SMALLINT
    )
AS
BEGIN
    SELECT
        MIN([wvfrm].[start_ft]) AS [start_time],
        MAX([wvfrm].[end_ft]) AS [end_time],
        [ct].[channel_code],
        [ct].[channel_type_id]
    FROM
        [dbo].[int_waveform] AS [wvfrm]
        INNER JOIN [dbo].[int_patient_channel] AS [pc] ON [wvfrm].[patient_channel_id] = [pc].[patient_channel_id]
        INNER JOIN [dbo].[int_channel_type] AS [ct] ON [pc].[channel_type_id] = [ct].[channel_type_id]
    WHERE
        ([wvfrm].[patient_id] = CAST(@PatientId AS UNIQUEIDENTIFIER))
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
        [dbo].[v_LegacyWaveform] AS [wvfrm]
        INNER JOIN [dbo].[v_PatientChannelLegacy] AS [vpcl] ON [wvfrm].[TypeId] = [vpcl].[TypeId]
        INNER JOIN [dbo].[v_LegacyChannelTypes] AS [ct] ON [vpcl].[TypeId] = [ct].[TypeId]
    WHERE
        ([wvfrm].[PatientId] = @PatientId)
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

