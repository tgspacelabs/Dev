


-- TODO: Just seperated the Legacy and ET. This need optimized.
CREATE PROCEDURE [dbo].[GetLegacyPatientVitalSignByChannels]
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
	SELECT   
	PATCHL.channel_type_id AS PATIENT_CHANNEL_ID,
	MSCODE.code as GDS_CODE,
	LiveValue.ResultValue AS VITAL_VALUE,	
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
)) ORDER BY VITAL_VALUE   
END
