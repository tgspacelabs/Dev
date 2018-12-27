


CREATE PROCEDURE [dbo].[GetGDSChannelList]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        [ch].[channel_type_id] AS [CHANNEL_TYPE_ID],
        [ch].[channel_code] AS [CODE],
        [ch].[label] AS [LABEL],
        [ch].[freq] AS [FREQUENCY],
        [ch].[min_value] AS [MIN_VALUE],
        [ch].[max_value] AS [MAX_VALUE],
        [ch].[sweep_speed] AS [SWEEP_SPEED],
        [ch].[priority] AS [PRIORITY],
        [ch].[type_cd] AS [TYPE_CD],
        [ch].[color] AS [COLOR],
        [ch].[units] AS [UNITS],
        [mc].[short_dsc] AS [SHORT_DESCRIPTION],
        [chv].[format_string] AS [FORMAT_STRING]
    FROM
        [dbo].[int_channel_type] [ch]
        INNER JOIN [dbo].[int_misc_code] [mc] ON [ch].[gds_cid] = [mc].[code_id]
        INNER JOIN [dbo].[int_channel_vital] [chv] ON [ch].[channel_type_id] = [chv].[channel_type_id]
    UNION ALL
    SELECT
        [vct].[ChannelTypeId] AS [CHANNEL_TYPE_ID],
        [vct].[ChannelCode] AS [CODE],
        [vct].[label] AS [LABEL],
        [vct].[SampleRate] AS [FREQUENCY],
        [ch].[min_value] AS [MIN_VALUE],
        [ch].[max_value] AS [MAX_VALUE],
        [ch].[sweep_speed] AS [SWEEP_SPEED],
        [ch].[priority] AS [PRIORITY],
        [ch].[type_cd] AS [TYPE_CD],
        [ch].[color] AS [COLOR],
        [ch].[units] AS [UNITS],
        NULL AS [SHORT_DESCRIPTION],
        [chv].[format_string] AS [FORMAT_STRING]
    FROM
        [dbo].[v_LegacyChannelTypes] [vct]
        LEFT OUTER JOIN [dbo].[int_channel_type] [ch] ON [ch].[channel_code] = [vct].[ChannelCode]
        INNER JOIN [dbo].[int_channel_vital] [chv] ON [ch].[channel_type_id] = [chv].[channel_type_id]
    ORDER BY
        [CHANNEL_TYPE_ID],
        [FORMAT_STRING];
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetGDSChannelList';

