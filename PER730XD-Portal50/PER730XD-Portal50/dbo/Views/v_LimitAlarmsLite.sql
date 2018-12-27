
CREATE VIEW [dbo].[v_LimitAlarmsLite]
AS
SELECT 
       [EndAlarms].[AlarmId]
       ,[v_PatientTopicSessions].[PatientId] AS [PatientId]
       ,[BeginAlarms].[SettingViolated]        -- SETTING VIOLATED MUST BE TAKEN FROM THE VERY FIRST ALARM UPDATE as the setting may change since the time alarm was violated
       ,[BeginAlarms].[ViolatingValue]           -- VIOLATED VALUE MUST BE TAKEN FROM THE VERY FIRST ALARM UPDATE. IT'S A BUSINESS REQUIREMENT.
       ,[IDEnumValue] AS [AlarmTypeId]
       ,[Enums].[Name] AS [AlarmType]
       ,[PriorityWeightValue]
       ,[EndAlarms].[StartDateTime] AS [StartDateTimeUTC]
       ,[EndAlarms].[EndDateTime] AS [EndDateTimeUTC]
       ,[TopicSessions].Id as [TopicSessionId]
       ,[TopicChannelCodes].[ChannelCode]
       ,[MDTopicLabel].[Value] as StrLabel
       ,[EndAlarms].[Leads]
       ,MDMessage.PairValue     as StrMessage
       ,MDLimitFormat.PairValue as StrLimitFormat
       ,MDValueFormat.PairValue as StrValueFormat
       ,Removed
        FROM 
                ( -- GET THE LATEST ALARM DATA FROM THE LAST RECEIVED ALARM UPDATE
                  SELECT    LimitAlarmsData.AlarmId, 
                            StartDateTime, 
                            EndDateTime, 
                            EnumGroupId,
                            IDEnumValue,
                            TopicSessionId,
                            Leads
                  FROM LimitAlarmsData
                  INNER JOIN 
                  (
                      select AlarmId, MAX(AcquiredDateTimeUtc) as AcquiredDateTimeUtc from LimitAlarmsData
                      group by AlarmId
                  ) MaxAlarms 
                  on MaxAlarms.AlarmId = LimitAlarmsData.AlarmId and LimitAlarmsData.AcquiredDateTimeUTC = MaxAlarms.AcquiredDateTimeUtc


                ) [EndAlarms] 
        INNER JOIN 
                (  -- THE VERY FIRST UPDATE ON THE ALARM

                    SELECT  LimitAlarmsData.AlarmId, 
                            TopicSessionId,
                            ViolatingValue, 
                            SettingViolated, 
                            PriorityWeightValue
                    FROM
                    LimitAlarmsData
                  INNER JOIN 
                  (
                  select AlarmId, MIN(AcquiredDateTimeUtc) as AcquiredDateTimeUtc from LimitAlarmsData
                  group by AlarmId
                  ) MinAlarms 
                  on MinAlarms.AlarmId = LimitAlarmsData.AlarmId and LimitAlarmsData.AcquiredDateTimeUTC = MinAlarms.AcquiredDateTimeUtc


                ) AS [BeginAlarms] ON [EndAlarms].AlarmId = BeginAlarms.AlarmId

      INNER JOIN [dbo].[Enums] ON [Enums].[GroupId] = [EndAlarms].[EnumGroupId] and [EndAlarms].[IDEnumValue] = [Enums].[Value]
      INNER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id] = [EndAlarms].[TopicSessionId]
      INNER JOIN [dbo].[v_PatientTopicSessions] ON [v_PatientTopicSessions].[TopicSessionId] = [TopicSessions].[Id]
      LEFT OUTER JOIN [dbo].[RemovedAlarms] ON [RemovedAlarms].[AlarmId] = [EndAlarms].[AlarmId]
      LEFT JOIN
      (

            SELECT CorrespondingWaveformTypes.TopicTypeId, [Label], CorrespondingWaveformTypes.[ChannelCode] from [v_LegacyChannelTypes] AllTypes inner join

            -- here we need to select only topic types which means the type of the first waveform available on the topic, or just the type of the topic itself, if no waveform is available
            (SELECT TopicTypeId, Min(ChannelCode) as ChannelCode
                FROM [dbo].[v_LegacyChannelTypes] group by TopicTypeId)
             CorrespondingWaveformTypes
                    on CorrespondingWaveformTypes.ChannelCode = AllTypes.ChannelCode and 
                    CorrespondingWaveformTypes.TopicTypeId = AllTypes.TopicTypeId


      ) AS [TopicChannelCodes] ON [TopicChannelCodes].[TopicTypeId] = [TopicSessions].[TopicTypeId]
        left outer join
            (SELECT     EntityMemberName, PairValue, TopicTypeId
            FROM      [dbo].[v_MetaData]
            WHERE     EntityName='LimitAlarms' and PairName='Message') AS MDMessage ON MDMessage.EntityMemberName = [Enums].[Name] and MDMessage.TopicTypeId = [TopicSessions].TopicTypeId
        left outer join
            (SELECT     EntityMemberName, PairValue, TopicTypeId
            FROM      [dbo].[v_MetaData]
            WHERE     EntityName='LimitAlarms' and PairName='LimitFormat') AS MDLimitFormat ON MDLimitFormat.EntityMemberName = [Enums].[Name] and MDLimitFormat.TopicTypeId = [TopicSessions].TopicTypeId
        left outer join
            (SELECT     EntityMemberName, PairValue, TopicTypeId
            FROM      [dbo].[v_MetaData]
            WHERE     EntityName='LimitAlarms' and PairName='ValueFormat') AS MDValueFormat ON MDValueFormat.EntityMemberName = [Enums].[Name] and MDValueFormat.TopicTypeId = [TopicSessions].TopicTypeId
        left outer join
            [dbo].[v_MetaData] AS MDTopicLabel
        ON MDTopicLabel.TopicTypeId = [TopicSessions].TopicTypeId and EntityName IS NULL and MDTopicLabel.Name='Label'
