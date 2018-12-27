
CREATE PROCEDURE [dbo].[GetProcStatList]
  (
  @PatientID   DPATIENT_ID,
  @TimeTagType INT,
  @StartTime   BIGINT,
  @EndTime     BIGINT
  )
AS
  BEGIN
  DECLARE @l_PatientID   DPATIENT_ID = @PatientID
  DECLARE @l_TimeTagType INT =@TimeTagType
  DECLARE @l_StartTime   BIGINT = @StartTime
  DECLARE @l_EndTime     BIGINT = @EndTime;

    WITH [Temp] AS
    (
        SELECT [start_ft] = [param_ft], [value1], CAST(224 AS SMALLINT) [sample_rate], [patient_channel_id]
            FROM [dbo].[int_param_timetag]
        WHERE [patient_id] = @l_PatientID AND [timetag_type] = @l_TimeTagType AND ([param_ft] BETWEEN @l_StartTime AND @l_EndTime)
    )

    SELECT [param_ft] = [Temp].[start_ft], [value1], [sample_rate], [Temp].[patient_channel_id]
        FROM [Temp]
        LEFT OUTER JOIN [dbo].[v_DiscardedOverlappingLegacyWaveformData] AS [Discarded]
            ON [Discarded].[patient_channel_id] = [Temp].[patient_channel_id]
            AND [Temp].[start_ft] BETWEEN [Discarded].[start_ft] AND [Discarded].[end_ft]
        WHERE [Discarded].[patient_channel_id] IS NULL

    ORDER BY [param_ft]
  END

