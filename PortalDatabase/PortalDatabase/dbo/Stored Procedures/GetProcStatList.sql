CREATE PROCEDURE [dbo].[GetProcStatList]
    (
     @PatientId [dbo].[DPATIENT_ID], -- TG - should be UNIQUEIDENTIFIER
     @TimeTagType INT,
     @StartTime BIGINT,
     @EndTime BIGINT
    )
AS
BEGIN
    WITH    [Temp]
              AS (SELECT
                    [start_ft] = [ipt].[param_ft],
                    [ipt].[value1],
                    CAST(224 AS SMALLINT) [sample_rate],
                    [ipt].[patient_channel_id]
                  FROM
                    [dbo].[int_param_timetag] AS [ipt]
                  WHERE
                    [ipt].[patient_id] = CAST(@PatientId AS UNIQUEIDENTIFIER)
                    AND [ipt].[timetag_type] = @TimeTagType
                    AND ([ipt].[param_ft] BETWEEN @StartTime AND @EndTime)
                 )
        SELECT
            [param_ft] = [Temp].[start_ft],
            [Temp].[value1],
            [Temp].[sample_rate],
            [Temp].[patient_channel_id]
        FROM
            [Temp]
            LEFT OUTER JOIN [dbo].[v_DiscardedOverlappingLegacyWaveformData] AS [Discarded]
                ON [Discarded].[patient_channel_id] = [Temp].[patient_channel_id]
                   AND [Temp].[start_ft] BETWEEN [Discarded].[start_ft]
                                         AND     [Discarded].[end_ft]
        WHERE
            [Discarded].[patient_channel_id] IS NULL
        ORDER BY
            [param_ft];
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Get proc stat list.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetProcStatList';

