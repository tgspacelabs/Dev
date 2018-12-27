

CREATE PROCEDURE [dbo].[GetGDSChannelList] 
AS
BEGIN
  SELECT 
    ch.channel_type_id AS CHANNEL_TYPE_ID,
    channel_code AS CODE,
    label AS LABEL,
    freq AS FREQUENCY,
    min_value AS MIN_VALUE,
    max_value AS MAX_VALUE,
    sweep_speed AS SWEEP_SPEED,
    priority AS PRIORITY,
    type_cd AS TYPE_CD,
    color AS COLOR,
    units AS UNITS,
    short_dsc AS SHORT_DESCRIPTION,
    format_string AS FORMAT_STRING
  FROM 
    dbo.int_channel_type ch 
  INNER JOIN 
    dbo.int_misc_code mc ON ch.gds_cid = mc.code_id
  INNER JOIN 
    dbo.int_channel_vital chv ON ch.channel_type_id = chv.channel_type_id
  
  UNION ALL
  
	SELECT vct.ChannelTypeId as CHANNEL_TYPE_ID,
			vct.ChannelCode as CODE,
			vct.[Label] as LABEL,
			vct.[SampleRate] as FREQUENCY,
			ch.min_value as MIN_VALUE,
			ch.max_value as MAX_VALUE,
			ch.sweep_speed as SWEEP_SPEED,
			ch.[priority] as PRIORITY,
			ch.type_cd as TYPE_CD,
			ch.color as COLOR,
			ch.units as UNITS,
			NULL as SHORT_DESCRIPTION,
			format_string as FORMAT_STRING
	FROM [dbo].[v_LegacyChannelTypes]   vct
	LEFT OUTER JOIN int_channel_type ch on ch.channel_code = vct.ChannelCode
	inner join dbo.int_channel_vital chv ON ch.channel_type_id = chv.channel_type_id
  
  ORDER BY 
    CHANNEL_TYPE_ID, FORMAT_STRING
END
