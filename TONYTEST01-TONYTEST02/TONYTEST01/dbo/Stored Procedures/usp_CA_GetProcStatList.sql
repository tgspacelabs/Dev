


CREATE PROCEDURE [dbo].[usp_CA_GetProcStatList]
  (
  @PatientID   DPATIENT_ID,
  @TimeTagType INT,
  @StartTime   BIGINT,
  @EndTime     BIGINT
  )
AS
  BEGIN	
		SELECT [param_ft], [value1], CAST(224 AS SMALLINT) [sample_rate], [patient_channel_id]
			FROM [dbo].[int_param_timetag]
		WHERE [patient_id] = @PatientID AND [timetag_type] = @TimeTagType AND ([param_ft] BETWEEN @StartTime AND @EndTime)	
	ORDER BY [param_ft]
  END

