
CREATE PROCEDURE [dbo].[GetLeadList]
  (
  @PatientID   DUSER_ID,
  @TimeTagType INT,
  @StartTime   BIGINT,
  @EndTime     BIGINT
  )
AS
  BEGIN
    SELECT param_ft,
           value1,
           value2
    FROM   dbo.int_param_timetag
	LEFT OUTER JOIN v_DiscardedOverlappingLegacyWaveformData AS discarded
		ON discarded.patient_channel_id = int_param_timetag.patient_channel_id
		AND int_param_timetag.param_ft BETWEEN discarded.start_ft AND discarded.end_ft
    WHERE  patient_id = @PatientID AND timetag_type = @TimeTagType AND ( param_ft >= @StartTime ) AND ( param_ft <= @EndTime )
	AND discarded.patient_channel_id IS NULL
    ORDER  BY param_ft;

  END


