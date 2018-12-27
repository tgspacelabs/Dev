


CREATE PROCEDURE [dbo].[usp_SaveLimitAlarmDataSet]
    (
     @LimitAlarmsData [dbo].LimitAlarmsDataType READONLY
    )
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[AlarmsStatusData]
            ([Id],
             [AlarmId],
             [StatusValue],
             [AcquiredDateTimeUTC],
             [Leads],
             [WaveformFeedTypeId],
             [TopicSessionId],
             [FeedTypeId],
             [IDEnumValue],
             [EnumGroupId]
	        )
    SELECT
        NEWID(),
        [AlarmId],
        [StatusValue],
        [AcquiredDateTimeUTC],
        [Leads],
        [WaveformFeedTypeId],
        [TopicSessionId],
        [FeedTypeId],
        [IDEnumValue],
        [EnumGroupId]
    FROM
        @LimitAlarmsData
    WHERE
        [StartDateTime] IS NULL;

    MERGE INTO [dbo].[LimitAlarmsData] AS [Dest]
    USING
        (SELECT
            [StartingUpdatesSequence].[AlarmId],
            [StartingUpdatesSequence].[SettingViolated],
            [StartingUpdatesSequence].[ViolatingValue],
            [StartingUpdatesSequence].[StartDateTime],
            [EndDateTime] = ISNULL([EndingUpdatesSequence].[EndDateTime], [EndTimeUTC]),
            [StartingUpdatesSequence].[StatusValue],
            [StartingUpdatesSequence].[DetectionTimestamp],
            [StartingUpdatesSequence].[Acknowledged],
            [StartingUpdatesSequence].[PriorityWeightValue],
            [StartingUpdatesSequence].[AcquiredDateTimeUTC],
            [StartingUpdatesSequence].[Leads],
            [StartingUpdatesSequence].[WaveformFeedTypeId],
            [StartingUpdatesSequence].[TopicSessionId],
            [StartingUpdatesSequence].[FeedTypeId],
            [StartingUpdatesSequence].[IDEnumValue],
            [StartingUpdatesSequence].[EnumGroupId]
         FROM
            (SELECT
                [AlarmId],
                [SettingViolated],
                [ViolatingValue],
                [StartDateTime],
                [StatusValue],
                [DetectionTimestamp],
                [Acknowledged],
                [PriorityWeightValue],
                [AcquiredDateTimeUTC],
                [Leads],
                [WaveformFeedTypeId],
                [TopicSessionId],
                [FeedTypeId],
                [IDEnumValue],
                [EnumGroupId],
                [R] = ROW_NUMBER() OVER (PARTITION BY [AlarmId] ORDER BY [AcquiredDateTimeUTC] ASC)
             FROM
                @LimitAlarmsData
             WHERE
                [StartDateTime] IS NOT NULL
            ) AS [StartingUpdatesSequence]
            LEFT OUTER JOIN (SELECT
                                [AlarmId],
                                [EndDateTime],
                                [R] = ROW_NUMBER() OVER (PARTITION BY [AlarmId] ORDER BY [AcquiredDateTimeUTC] DESC)
                             FROM
                                @LimitAlarmsData
                             WHERE
                                [EndDateTime] IS NOT NULL
                            ) AS [EndingUpdatesSequence] ON [EndingUpdatesSequence].[AlarmId] = [StartingUpdatesSequence].[AlarmId]
                                                            AND [EndingUpdatesSequence].[R] = 1
            LEFT OUTER JOIN [dbo].[TopicSessions] ON [Id] = [StartingUpdatesSequence].[TopicSessionId]
         WHERE
            [StartingUpdatesSequence].[R] = 1
        ) AS [Src]
    ON [Src].[AlarmId] = [Dest].[AlarmId]
    WHEN NOT MATCHED BY TARGET THEN
        INSERT
               ([AlarmId],
                [SettingViolated],
                [ViolatingValue],
                [StartDateTime],
                [EndDateTime],
                [StatusValue],
                [DetectionTimestamp],
                [Acknowledged],
                [PriorityWeightValue],
                [AcquiredDateTimeUTC],
                [Leads],
                [WaveformFeedTypeId],
                [TopicSessionId],
                [FeedTypeId],
                [IDEnumValue],
                [EnumGroupId]
			   )
        VALUES ([Src].[AlarmId],
                [Src].[SettingViolated],
                [Src].[ViolatingValue],
                [Src].[StartDateTime],
                [Src].[EndDateTime],
                [Src].[StatusValue],
                [Src].[DetectionTimestamp],
                [Src].[Acknowledged],
                [Src].[PriorityWeightValue],
                [Src].[AcquiredDateTimeUTC],
                [Src].[Leads],
                [Src].[WaveformFeedTypeId],
                [Src].[TopicSessionId],
                [Src].[FeedTypeId],
                [Src].[IDEnumValue],
                [Src].[EnumGroupId]
			   )
    WHEN MATCHED THEN
        UPDATE SET
               [Dest].[EndDateTime] = [Src].[EndDateTime];

END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_SaveLimitAlarmDataSet';

