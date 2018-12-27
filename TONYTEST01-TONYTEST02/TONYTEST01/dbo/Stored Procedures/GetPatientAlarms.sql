

CREATE PROCEDURE [dbo].[GetPatientAlarms] (@patient_id UNIQUEIDENTIFIER, @start_ft bigint, @end_ft bigint, @locale varchar(7)='en') 
AS
BEGIN

	DECLARE @end_dt DATETIME = dbo.fnFileTimeToDateTime(@end_ft)
	DECLARE @start_dt DATETIME=dbo.fnFileTimeToDateTime(@start_ft)
	DECLARE @locale_arg VARCHAR(7)=@locale
	DECLARE @patient_id_arg UNIQUEIDENTIFIER=@patient_id

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
		WHERE  [int_alarm].[patient_id] = @patient_id_arg
		AND [alarm_level] > 0
		AND (( @start_ft < [int_alarm].[end_ft])  OR ([int_alarm].[end_ft] IS NULL))

UNION ALL

	SELECT LimitAlarmsData.[AlarmId] as [Id]
	      ,[TYPE] = [TopicFeedTypes].[ChannelCode]
		  ,[TypeString] = ISNULL([Message], [AlarmTypeName])
		  ,[Title] = ISNULL([Message], '') + '  ' + REPLACE(ISNULL([ValueFormat],''), '{0}', [ViolatingValue]) + '  ' + replace(ISNULL([LimitFormat],''), '{0}', [SettingViolated])
		  ,[START_FT] = [dbo].[fnDateTimeToFileTime]([StartDateTime])
		  ,[END_FT] = [dbo].[fnDateTimeToFileTime]([EndDateTime])
		  ,[START_DT] = CAST(NULL AS DATETIME)
		  ,[Removed]
		  ,[PRIORITY] = CASE 
							WHEN [PriorityWeightValue] = 0 THEN 0  -- none/message
							WHEN [PriorityWeightValue] = 1 THEN 3  -- low
							WHEN [PriorityWeightValue] = 2 THEN 2  -- medium
							ELSE 1                                 -- high
                        END
		  ,[Label] = CAST('' AS NVARCHAR(250))
		FROM
		LimitAlarmsData	
				INNER JOIN [dbo].[AlarmResources] ON [AlarmResources].[EnumGroupId]=[LimitAlarmsData].[EnumGroupId] AND [AlarmResources].[IDEnumValue]=[LimitAlarmsData].[IDEnumValue] AND [AlarmResources].[Locale]=@locale_arg
				INNER JOIN [dbo].[TopicFeedTypes] ON [TopicFeedTypes].[FeedTypeId]=LimitAlarmsData.[WaveformFeedTypeId]
				INNER JOIN [v_PatientTopicSessions] on [v_PatientTopicSessions].TopicSessionId = LimitAlarmsData.TopicSessionId 
				LEFT OUTER JOIN [dbo].[RemovedAlarms] ON [RemovedAlarms].[AlarmId]=LimitAlarmsData.[AlarmId]
		Where 
			[v_PatientTopicSessions].[PatientId]=@patient_id_arg
			AND [StartDateTime] <= @end_dt AND ([EndDateTime] IS NULL OR @start_dt <= [EndDateTime])

UNION ALL
SELECT [Id] = [GeneralAlarmsData].[AlarmId]
	      ,[TYPE] = [TopicFeedTypes].[ChannelCode]
		  ,[TypeString] = ISNULL([Message], [AlarmTypeName])
		  ,[Title] = ISNULL([Message], '')
		  ,[START_FT] = [dbo].[fnDateTimeToFileTime]([StartDateTime])
		  ,[END_FT] = [dbo].[fnDateTimeToFileTime]([EndDateTime])
		  ,[START_DT] = CAST(NULL AS DATETIME)
		  ,[Removed]
		  ,[PRIORITY] = CASE 
							WHEN [PriorityWeightValue] = 0 THEN 0  -- none/message
							WHEN [PriorityWeightValue] = 1 THEN 3  -- low
							WHEN [PriorityWeightValue] = 2 THEN 2  -- medium
							ELSE 1                                 -- high
                        END
		  ,[Label] = CAST('' AS NVARCHAR(250))
		FROM [dbo].[GeneralAlarmsData]
		INNER JOIN [dbo].[AlarmResources]
					ON [AlarmResources].[EnumGroupId]=[GeneralAlarmsData].[EnumGroupId]
					AND [AlarmResources].[IDEnumValue]=[GeneralAlarmsData].[IDEnumValue]
					AND [AlarmResources].[Locale]=@locale_arg

		INNER JOIN [dbo].[TopicFeedTypes] ON [TopicFeedTypes].[FeedTypeId]=[GeneralAlarmsData].[WaveformFeedTypeId]
		INNER JOIN [v_PatientTopicSessions] on [v_PatientTopicSessions].TopicSessionId = [GeneralAlarmsData].TopicSessionId 
		LEFT OUTER JOIN [dbo].[RemovedAlarms]
			ON [RemovedAlarms].[AlarmId]=[GeneralAlarmsData].[AlarmId]
		Where 
			[v_PatientTopicSessions].[PatientId]=@patient_id_arg
			AND [StartDateTime] <= @end_dt
			AND ([EndDateTime] IS NULL OR @start_dt <= [EndDateTime])
  ORDER BY [start_ft];
  END

