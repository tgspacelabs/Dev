CREATE TABLE [dbo].[GeneralAlarmsData] (
    [AlarmId]             UNIQUEIDENTIFIER NOT NULL,
    [StatusTimeout]       TINYINT          NULL,
    [StartDateTime]       DATETIME         NOT NULL,
    [EndDateTime]         DATETIME         NULL,
    [StatusValue]         INT              NOT NULL,
    [PriorityWeightValue] INT              NOT NULL,
    [AcquiredDateTimeUTC] DATETIME         NOT NULL,
    [Leads]               INT              NOT NULL,
    [WaveformFeedTypeId]  UNIQUEIDENTIFIER NOT NULL,
    [TopicSessionId]      UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]          UNIQUEIDENTIFIER NOT NULL,
    [IDEnumValue]         INT              NOT NULL,
    [EnumGroupId]         UNIQUEIDENTIFIER NOT NULL,
    [Sequence]            BIGINT           IDENTITY (-9223372036854775808, 1) NOT NULL,
    CONSTRAINT [PK_GeneralAlarmsData_StartDateTime_Sequence] PRIMARY KEY CLUSTERED ([StartDateTime] ASC, [Sequence] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE NONCLUSTERED INDEX [IX_GeneralAlarmsData_TopicSessionId_StartDateTime_EndDateTime_includes]
    ON [dbo].[GeneralAlarmsData]([TopicSessionId] ASC, [StartDateTime] ASC, [EndDateTime] ASC)
    INCLUDE([AlarmId], [StatusTimeout], [StatusValue], [PriorityWeightValue], [AcquiredDateTimeUTC], [Leads], [WaveformFeedTypeId], [FeedTypeId], [IDEnumValue], [EnumGroupId]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_GeneralAlarmsData_TopicSessionId_AcquiredDateTimeUTC_includes]
    ON [dbo].[GeneralAlarmsData]([TopicSessionId] ASC, [AcquiredDateTimeUTC] ASC)
    INCLUDE([AlarmId], [StartDateTime], [PriorityWeightValue], [WaveformFeedTypeId], [IDEnumValue], [EnumGroupId], [EndDateTime]) WITH (FILLFACTOR = 100);


GO
CREATE NONCLUSTERED INDEX [IX_GeneralAlarmsData_StartDateTime_AlarmId_Sequence]
    ON [dbo].[GeneralAlarmsData]([StartDateTime] ASC)
    INCLUDE([AlarmId], [Sequence]) WITH (FILLFACTOR = 100);


GO
CREATE TRIGGER [dbo].[trg_Copy_General_Alarm] ON [dbo].[GeneralAlarmsData]
    FOR INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

	MERGE
		INTO [dbo].[int_print_job_et_alarm] AS [Destination]
		USING
		(
			SELECT
				[AlarmId] = [Inserted].[AlarmId],
				[PatientId] = [LatestPatientAssignment].[PatientId],
				[TopicSessionId] = [TopicSessions].[Id],
				[DeviceSessionId] = [DeviceSessions].[Id],
				[AlarmStartTimeUTC] = [Inserted].[StartDateTime],
				[AlarmEndTimeUTC] = [Inserted].[EndDateTime],
				[StrTitleLabel] = [AlarmResources].[Label],
				[FirstName] = [int_person].[first_nm],
				[LastName] = [int_person].[last_nm],
				[FullName] = ISNULL([int_person].[last_nm], '') + ', ' + ISNULL([int_person].[first_nm], ''),
				[ID1] = [int_mrn_map].[mrn_xid],
				[ID2] = [int_mrn_map].[mrn_xid2],
				[DOB] = [int_patient].[dob],
				[FacilityName] = [v_DeviceSessionAssignment].[FacilityName],
				[UnitName] = [v_DeviceSessionAssignment].[UnitName],
				[MonitorName] = [v_DeviceSessionAssignment].[MonitorName],
				[StrMessage] = [AlarmResources].[StrMessage]
			FROM [Inserted]
			INNER JOIN [dbo].[TopicSessions]
				ON [TopicSessions].[Id] = [Inserted].[TopicSessionId]
			INNER JOIN [dbo].[DeviceSessions]
				ON [DeviceSessions].[Id] = [TopicSessions].[DeviceSessionId]
			INNER JOIN (SELECT
                        [PatientSessionId],
                        [PatientId]
                    FROM
                        (SELECT
                            [PatientSessionId],
                            [PatientId],
                            ROW_NUMBER() OVER (PARTITION BY [PatientSessionId] ORDER BY [Sequence] DESC) AS [RowNumber]
                         FROM
                            [dbo].[PatientSessionsMap]
                        ) AS [PatientAssignmentSequence]
                    WHERE
                        [PatientAssignmentSequence].[RowNumber] = 1
                   ) AS [LatestPatientAssignment]
				ON [LatestPatientAssignment].[PatientSessionId] = [TopicSessions].[PatientSessionId]
				LEFT OUTER JOIN [dbo].[int_mrn_map]
					ON [int_mrn_map].[patient_id] = [LatestPatientAssignment].[PatientId]
						AND [int_mrn_map].[merge_cd] = 'C'
				LEFT OUTER JOIN [dbo].[int_patient]
					ON [int_patient].[patient_id] = [LatestPatientAssignment].[PatientId]
				LEFT OUTER JOIN [dbo].[int_person]
					ON [int_person].[person_id] = [LatestPatientAssignment].[PatientId]
				INNER JOIN [dbo].[v_DeviceSessionAssignment]
					ON [v_DeviceSessionAssignment].[DeviceSessionId] = [DeviceSessions].[Id]
				INNER JOIN [dbo].[AlarmResources]
					ON [AlarmResources].[EnumGroupId] = [Inserted].[EnumGroupId]
					   AND [AlarmResources].[IDEnumValue] = [Inserted].[IDEnumValue]
					   AND [Locale] = 'en'
			WHERE
				-- SR0006 : Microsoft.Rules.Data : A column in an expression to be compared in a predicate might cause a table scan and degrade performance.
				-- See article "When the DRY principle doesn't apply : BITWISE operations in SQL Server" abut the fix - http://sqlperformance.com/2012/08/t-sql-queries/dry-principle-bitwise-operations
				[Inserted].[StatusValue] >= 32
				AND [Inserted].[StatusValue] & 32 = 32
		    ) AS [Source]
		ON [Source].[AlarmId] = [Destination].[AlarmId]
		WHEN NOT MATCHED BY TARGET THEN
			INSERT
			([AlarmId],
             [PatientId],
             [TopicSessionId],
             [DeviceSessionId],
             [AlarmStartTimeUTC],
             [AlarmEndTimeUTC],
             [StrTitleLabel],
             [FirstName],
             [LastName],
             [FullName],
             [ID1],
             [ID2],
             [DOB],
             [FacilityName],
             [UnitName],
             [MonitorName],
             [StrMessage],
		     [RowLastUpdatedOn])
			VALUES
			([AlarmId],
             [PatientId],
             [TopicSessionId],
             [DeviceSessionId],
             [AlarmStartTimeUTC],
             [AlarmEndTimeUTC],
             [StrTitleLabel],
             [FirstName],
             [LastName],
             [FullName],
             [ID1],
             [ID2],
             [DOB],
             [FacilityName],
             [UnitName],
             [MonitorName],
             [StrMessage],
		     CAST(GETDATE() AS SMALLDATETIME))
		WHEN MATCHED THEN
			UPDATE  SET
				[AlarmEndTimeUTC] = [Source].[AlarmEndTimeUTC],
				[RowLastUpdatedOn] = CAST(GETDATE() AS SMALLDATETIME);
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contains information about general alarms for patient topic sessions.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'GeneralAlarmsData';

