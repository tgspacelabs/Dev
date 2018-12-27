

CREATE PROCEDURE [dbo].[usp_SaveLimitAlarmDataSet]
    (@LimitAlarmsData dbo.LimitAlarmsDataType READONLY)
AS
BEGIN

    SET NOCOUNT ON

    INSERT INTO dbo.AlarmsStatusData
    (
        Id,
        AlarmId,
        StatusValue,
        AcquiredDateTimeUTC,
        Leads,
        WaveformFeedTypeId,
        TopicSessionId,
        FeedTypeId,
        IDEnumValue,
        EnumGroupId
    )
    SELECT
        NEWID(),
        AlarmId,
        StatusValue,
        AcquiredDateTimeUTC,
        Leads,
        WaveformFeedTypeId,
        TopicSessionId,
        FeedTypeId,
        IDEnumValue,
        EnumGroupId
    FROM @LimitAlarmsData
    WHERE [StartDateTime] IS NULL

    MERGE
        INTO [dbo].[LimitAlarmsData] AS [Dest]
        USING
        (
            SELECT [StartingUpdatesSequence].[AlarmId]
                  ,[SettingViolated]
                  ,[ViolatingValue]
                  ,[StartDateTime]
                  ,[EndDateTime]
                  ,[StatusValue]
                  ,[DetectionTimestamp]
                  ,[Acknowledged]
                  ,[PriorityWeightValue]
                  ,[AcquiredDateTimeUTC]
                  ,[Leads]
                  ,[WaveformFeedTypeId]
                  ,[TopicSessionId]
                  ,[FeedTypeId]
                  ,[IDEnumValue]
                  ,[EnumGroupId]
            FROM
            (
                SELECT [AlarmId]
                      ,[SettingViolated]
                      ,[ViolatingValue]        
                      ,[StartDateTime]
                      ,[StatusValue]
                      ,[DetectionTimestamp]
                      ,[Acknowledged]
                      ,[PriorityWeightValue]
                      ,[AcquiredDateTimeUTC]
                      ,[Leads]
                      ,[WaveformFeedTypeId]
                      ,[TopicSessionId]
                      ,[FeedTypeId]
                      ,[IDEnumValue]
                      ,[EnumGroupId]
                      ,[R] = ROW_NUMBER() OVER (PARTITION BY [AlarmId] ORDER BY [AcquiredDateTimeUTC] ASC)
                    FROM @LimitAlarmsData
                    WHERE [StartDateTime] IS NOT NULL
            ) AS [StartingUpdatesSequence]
            LEFT OUTER JOIN
            (
                SELECT [AlarmId]
                      ,[EndDateTime]
                      ,[R] = ROW_NUMBER() OVER (PARTITION BY [AlarmId] ORDER BY [AcquiredDateTimeUTC] DESC)
                    FROM @LimitAlarmsData
                    WHERE [EndDateTime] IS NOT NULL
            ) AS [EndingUpdatesSequence]
                ON [EndingUpdatesSequence].[AlarmId]=[StartingUpdatesSequence].[AlarmId]
                AND [EndingUpdatesSequence].[R]=1
            WHERE [StartingUpdatesSequence].[R]=1
        ) AS [Src]
        ON [Src].[AlarmId]=[Dest].[AlarmId]
        WHEN NOT MATCHED BY TARGET
            THEN INSERT
            (
                 [AlarmId]
                ,[SettingViolated]
                ,[ViolatingValue]
                ,[StartDateTime]
                ,[EndDateTime]
                ,[StatusValue]
                ,[DetectionTimestamp]
                ,[Acknowledged]
                ,[PriorityWeightValue]
                ,[AcquiredDateTimeUTC]
                ,[Leads]
                ,[WaveformFeedTypeId]
                ,[TopicSessionId]
                ,[FeedTypeId]
                ,[IDEnumValue]
                ,[EnumGroupId]
            )
            VALUES
            (
                 [Src].[AlarmId]
                ,[Src].[SettingViolated]
                ,[Src].[ViolatingValue] 
                ,[Src].[StartDateTime]
                ,[Src].[EndDateTime]
                ,[Src].[StatusValue]
                ,[Src].[DetectionTimestamp]
                ,[Src].[Acknowledged]
                ,[Src].[PriorityWeightValue]
                ,[Src].[AcquiredDateTimeUTC]
                ,[Src].[Leads]
                ,[Src].[WaveformFeedTypeId]
                ,[Src].[TopicSessionId]
                ,[Src].[FeedTypeId]
                ,[Src].[IDEnumValue]
                ,[Src].[EnumGroupId]
            )
        WHEN MATCHED
            THEN UPDATE SET [Dest].[EndDateTime]=[Src].[EndDateTime]
        ;

END

