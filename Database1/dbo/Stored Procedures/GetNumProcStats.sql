

CREATE PROCEDURE [dbo].[GetNumProcStats]
    (
     @PatientID DPATIENT_ID,
     @TimeTagType INT,
     @StartTime BIGINT,
     @EndTime BIGINT
    )
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        COUNT([value1]) AS [NUM_PROC_STATS]
    FROM
        [dbo].[int_param_timetag]
        LEFT OUTER JOIN [dbo].[v_DiscardedOverlappingLegacyWaveformData] AS [discarded] ON [discarded].[patient_channel_id] = [int_param_timetag].[patient_channel_id]
                                                                                           AND [param_ft] BETWEEN [discarded].[start_ft]
                                                                                                          AND     [discarded].[end_ft]
    WHERE
        [patient_id] = @PatientID
        AND [timetag_type] = @TimeTagType
        AND ([param_ft] >= @StartTime)
        AND ([param_ft] <= @EndTime)
        AND [discarded].[patient_channel_id] IS NULL; 
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'GetNumProcStats';

