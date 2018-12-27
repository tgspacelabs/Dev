


CREATE PROCEDURE [dbo].[GetPatientVitalSignByChannels]
( 
  @patientId      UNIQUEIDENTIFIER,
  @ChannelTypes [dbo].[StringList] READONLY
)
AS
BEGIN
DECLARE @VitalValue [dbo].[VitalValues]
	INSERT into @VitalValue
	SELECT vital_value FROM int_vital_live WHERE Patient_id=@PatientId;	  
 
	((
		SELECT --*
		 TopicFeedTypes.FeedTypeId AS PATIENT_CHANNEL_ID
		,VitalsAll.GdsCode AS GDS_CODE
		,VitalsAll.Value AS VITAL_VALUE
		,int_channel_vital.format_string AS FORMAT_STRING
		FROM 
		@ChannelTypes CHT
		inner join TopicFeedTypes on TopicFeedTypes.FeedTypeId = CHT.Item
		inner join int_channel_vital on int_channel_vital.channel_type_id = TopicFeedTypes.ChannelTypeId
		inner join 
		(
			SELECT	ROW_NUMBER() OVER (PARTITION BY livedata.TopicInstanceId, GdsCode ORDER BY TimeStampUTC DESC) as ROW_NUMBER,
			livedata.FeedTypeId, livedata.TopicInstanceId, livedata.Name, livedata.Value, GdsCode, GdsCodeMap.CodeId
			from livedata
			INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].TopicInstanceId = LiveData.TopicInstanceId AND [TopicSessions].EndTimeUTC IS NULL
			INNER JOIN GdsCodeMap on GdsCodeMap.FeedTypeId = LiveData.FeedTypeId and GdsCodeMap.Name = LiveData.Name
			WHERE TopicSessions.Id in (select TopicSessionId from v_PatientTopicSessions where PatientId = @PatientId)
		) VitalsAll
		on VitalsAll.CodeId = int_channel_vital.gds_cid
		where VitalsAll.ROW_NUMBER = 1
	) 

UNION ALL

(
	SELECT --* 
	PATCHL.channel_type_id AS PATIENT_CHANNEL_ID,
	MSCODE.code as GDS_CODE,
	LiveValue.ResultValue AS VITAL_VALUE,
	--TODATETIMEOFFSET (convert(datetime,stuff(stuff(stuff(LiveTime.ResultTime, 9, 0, ' '), 12, 0, ':'), 15, 0, ':')) ,DATENAME(tz, SYSDATETIMEOFFSET()))  AS COLLECT_DT,
	CHVIT.format_string AS FORMAT_STRING
	FROM int_patient_channel AS PATCHL
	INNER JOIN int_channel_vital AS CHVIT
		ON PATCHL.channel_type_id=CHVIT.channel_type_id 
		AND PATCHL.active_sw=1
	INNER JOIN int_vital_live AS VITALRES
		On PATCHL.patient_id=VITALRES.Patient_id
	LEFT OUTER JOIN 
		  (
			  SELECT 
			  idx,
			  value,
			  SUBSTRING(value,CHARINDEX('=',value)+1,LEN(value)) AS ResultValue,
			  CONVERT(int,SUBSTRING(value,0,CHARINDEX('=',value)))  AS GdsCodeId
			  FROM dbo.fn_vital_Merge((@VitalValue),'|')
		  )
		AS LiveValue
		ON LiveValue.GdsCodeId=CHVIT.gds_cid	
	LEFT OUTER JOIN int_misc_code AS MSCODE
		ON MSCODE.code_id=CHVIT.gds_cid
		AND MSCODE.code IS NOT NULL
	WHERE PATCHL.patient_id=@patientId 
	AND PATCHL.channel_type_id IN (SELECT ITEM FROM @ChannelTypes)
	AND PATCHL.active_sw=1
	AND LiveValue.idx IS NOT NULL
) ) ORDER BY VITAL_VALUE
END

