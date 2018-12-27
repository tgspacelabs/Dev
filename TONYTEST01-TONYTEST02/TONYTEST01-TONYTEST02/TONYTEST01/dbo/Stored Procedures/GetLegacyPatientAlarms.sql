
CREATE PROCEDURE [dbo].[GetLegacyPatientAlarms] (@patient_id UNIQUEIDENTIFIER, @start_ft bigint, @end_ft bigint, @locale varchar(7)='en') 
AS
BEGIN 
    SELECT [Id] = [alarm_id]
          ,[TYPE] = [int_channel_type].[channel_code]
          ,[TypeString] = ISNULL(alarm_cd,'')
          ,[TITLE] = ISNULL(alarm_cd,'')
          ,[START_FT] = [start_ft]
          ,[END_FT] = [end_ft]
          ,[START_DT] = [start_dt]
          ,[Removed] = [removed]
          ,[PRIORITY] = [alarm_level]
          ,[Label] = CAST('' AS NVARCHAR(250))
		FROM [dbo].[int_alarm]
	    INNER JOIN [dbo].[int_patient_channel]
			ON [int_alarm].[patient_channel_id] = [int_patient_channel].[patient_channel_id]
		INNER JOIN [dbo].[int_channel_type]
		    ON [int_patient_channel].[channel_type_id] = [int_channel_type].[channel_type_id]
		WHERE  [int_alarm].[patient_id] = @patient_id
		AND [alarm_level] > 0
		AND (( @start_ft < [int_alarm].[end_ft])  OR ([int_alarm].[end_ft] IS NULL))
		ORDER BY [start_ft];
END
