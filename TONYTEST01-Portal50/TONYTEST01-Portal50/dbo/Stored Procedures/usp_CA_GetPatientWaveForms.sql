


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
@start_ft bigint, 
@end_ft bigint
)
AS
BEGIN

	DECLARE @l_start_ft BIGINT = @start_ft;
	DECLARE @l_end_ft BIGINT = @end_ft;
	DECLARE @l_start_ut DATETIME = dbo.fnFileTimeToDateTime(@l_start_ft);
	DECLARE @l_end_ut DATETIME = dbo.fnFileTimeToDateTime(@l_end_ft);
	DECLARE @l_patient_id UNIQUEIDENTIFIER = @patient_id;

	SELECT   dbo.fnDateTimeToFileTime(WaveformData.StartTimeUTC) as start_ft
			,dbo.fnDateTimeToFileTime(WaveformData.EndTimeUTC) as end_ft
			,CAST(NULL AS DATETIME) as start_dt
			,CAST(NULL AS DATETIME) as end_dt
			,CASE WHEN Compressed = 0 THEN NULL ELSE 'WCTZLIB' END  AS compress_method
			,Samples as waveform_data
			,TypeId as channel_id
	FROM WaveformData 
	where TypeId in (SELECT * FROM @channelIds)
		and WaveformData.TopicSessionId in (select TopicSessionId from v_PatientTopicSessions where PatientId=@l_patient_id)
        and WaveformData.StartTimeUTC <= @l_end_ut
		and WaveformData.EndTimeUTC > @l_start_ut
			
	UNION ALL

	SELECT  wfrm.start_ft
			,wfrm.end_ft
			,wfrm.start_dt
			,wfrm.end_dt
			,wfrm.compress_method
			,CAST(wfrm.waveform_data AS VARBINARY(MAX))
			,pc.channel_type_id as channel_id
		FROM 
		dbo.int_waveform wfrm WITH (NOLOCK)
		INNER JOIN 
		int_patient_channel pc ON wfrm.patient_channel_id = pc.patient_channel_id
		INNER JOIN
		int_patient_monitor pm ON pc.patient_monitor_id = pm.patient_monitor_id
		INNER JOIN
		int_encounter pe ON pm.encounter_id = pe.encounter_id
		WHERE 
		(wfrm.patient_id = @l_patient_id) AND
		(pc.channel_type_id IN (SELECT * FROM @channelIds)) AND
		(@l_start_ft < wfrm.end_ft) AND
		(@l_end_ft >= wfrm.start_ft)

    ORDER BY [start_ft]

END

