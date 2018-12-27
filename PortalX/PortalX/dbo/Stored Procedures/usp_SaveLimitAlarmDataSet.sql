CREATE PROCEDURE [dbo].[usp_SaveLimitAlarmDataSet]
    (
     @LimitAlarmsData [dbo].LimitAlarmsDataType READONLY
    )
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @ErrorMessage NVARCHAR(4000);
	DECLARE @ErrorSeverity INT;
	DECLARE @ErrorState INT;

	BEGIN TRY
		BEGIN TRAN

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
				[EnumGroupId]
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
					ROW_NUMBER() OVER (PARTITION BY [AlarmId] ORDER BY [AcquiredDateTimeUTC] ASC) AS [RowNumber]
				 FROM
					@LimitAlarmsData
				 WHERE
					[StartDateTime] IS NOT NULL
				) AS [StartingUpdatesSequence]
			 WHERE
				[StartingUpdatesSequence].[RowNumber] = 1
			) AS [Src]
		ON [Src].[AlarmId] = [Dest].[AlarmId]
		WHEN NOT MATCHED BY TARGET THEN
			INSERT
				   ([AlarmId],
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
					[EnumGroupId]
				   )
			VALUES ([Src].[AlarmId],
					[Src].[SettingViolated],
					[Src].[ViolatingValue],
					[Src].[StartDateTime],
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
				   );

		UPDATE [dbo].[LimitAlarmsData]
		SET [EndDateTime] = [Src].[EndDateTime]
		FROM
			(SELECT DISTINCT
				[StartDateTime],
				[EndDateTime] = ISNULL([EndingUpdatesSequence].[EndDateTime], [TopicSessions].[EndTimeUTC]),
				[TopicSessionId],
				[FeedTypeId],
				[IDEnumValue],
				[EnumGroupId]
			 FROM
				(SELECT
					[StartDateTime],
					[EndDateTime],
					[TopicSessionId],
					[FeedTypeId],
					[IDEnumValue],
					[EnumGroupId],
					ROW_NUMBER() OVER (PARTITION BY [AlarmId] ORDER BY [AcquiredDateTimeUTC] DESC) AS [RowNumber]
				 FROM
					@LimitAlarmsData
				 WHERE
					[StartDateTime] IS NOT NULL
				) AS [EndingUpdatesSequence]
				LEFT OUTER JOIN [dbo].[TopicSessions] ON [TopicSessions].[Id] = [EndingUpdatesSequence].[TopicSessionId]
			 WHERE
				[EndingUpdatesSequence].[RowNumber] = 1
			) AS [Src]
		WHERE [LimitAlarmsData].[TopicSessionId] = [Src].[TopicSessionId] AND
			  [LimitAlarmsData].[FeedTypeId] = [Src].[FeedTypeId] AND
			  [LimitAlarmsData].[IDEnumValue] = [Src].[IDEnumValue] AND
			  [LimitAlarmsData].[EnumGroupId] = [Src].[EnumGroupId] AND
			  [LimitAlarmsData].[StartDateTime] = [Src].[StartDateTime]

		COMMIT TRAN;
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN;

		SELECT
			@ErrorMessage = ERROR_MESSAGE(),
			@ErrorSeverity = ERROR_SEVERITY(),
			@ErrorState = ERROR_STATE();

		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH;
END;

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'PROCEDURE', @level1name = N'usp_SaveLimitAlarmDataSet';

