
CREATE PROCEDURE [dbo].[GetWaveFormTimes] (
@PatientID dPATIENT_ID,
@Channel1Code SMALLINT,
@Channel2Code SMALLINT)
AS
BEGIN
  SELECT
     MIN(wvfrm.start_ft) AS start_time,
     MAX(wvfrm.end_ft) AS end_time,
     ct.channel_code,
     ct.channel_type_id
  FROM
     dbo.int_waveform wvfrm
     INNER JOIN 
       dbo.int_patient_channel pc ON wvfrm.patient_channel_id = pc.patient_channel_id
     INNER JOIN 
       dbo.int_channel_type ct ON pc.channel_type_id = ct.channel_type_id
  WHERE
     (wvfrm.patient_id = @PatientID) AND
     (ct.channel_code = @Channel1Code OR
      ct.channel_code = @Channel2Code)
  GROUP BY
     ct.channel_code,
     ct.channel_type_id
     
     union all 

  SELECT
     MIN(wvfrm.FileTimeStampBeginUTC) AS start_time,
     MAX(wvfrm.FileTimeStampEndUTC) AS end_time,
     ct.ChannelCode as channel_code,
     ct.TypeId as channel_type_id
  FROM
     dbo.v_LegacyWaveform wvfrm
INNER JOIN 
    dbo.v_PatientChannelLegacy ON 
		wvfrm.TypeId = v_PatientChannelLegacy.TypeId
  INNER JOIN 
    dbo.v_LegacyChannelTypes ct ON v_PatientChannelLegacy.TypeId = ct.TypeId
  WHERE
     (wvfrm.PatientId = @PatientID) AND
     (ct.ChannelCode = @Channel1Code OR
      ct.ChannelCode = @Channel2Code)
  GROUP BY
     ct.ChannelCode,
     ct.TypeId
     
     
  ORDER BY
     channel_code
END

