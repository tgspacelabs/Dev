CREATE TABLE [dbo].[LimitAlarmsData] (
    [AlarmId]             UNIQUEIDENTIFIER NOT NULL,
    [SettingViolated]     VARCHAR (25)     NOT NULL,
    [ViolatingValue]      VARCHAR (25)     NOT NULL,
    [StartDateTime]       DATETIME         NOT NULL,
    [EndDateTime]         DATETIME         NULL,
    [StatusValue]         INT              NOT NULL,
    [DetectionTimestamp]  DATETIME         NULL,
    [Acknowledged]        BIT              NOT NULL,
    [PriorityWeightValue] INT              NOT NULL,
    [AcquiredDateTimeUTC] DATETIME         NOT NULL,
    [Leads]               INT              NOT NULL,
    [WaveformFeedTypeId]  UNIQUEIDENTIFIER NOT NULL,
    [TopicSessionId]      UNIQUEIDENTIFIER NOT NULL,
    [FeedTypeId]          UNIQUEIDENTIFIER NOT NULL,
    [IDEnumValue]         INT              NOT NULL,
    [EnumGroupId]         UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_LimitAlarmsData_AlarmId] PRIMARY KEY NONCLUSTERED ([AlarmId] ASC) WITH (FILLFACTOR = 100)
);


GO
CREATE UNIQUE CLUSTERED INDEX [CL_LimitAlarmsData_TopicSessionId_StartDateTime_EndDateTime_PriorityWeightValue_IDEnumValue]
    ON [dbo].[LimitAlarmsData]([TopicSessionId] ASC, [StartDateTime] ASC, [EndDateTime] ASC, [PriorityWeightValue] ASC, [IDEnumValue] ASC) WITH (FILLFACTOR = 100);


GO
CREATE TRIGGER [dbo].[trg_Copy_Limit_Alarm] ON [dbo].[LimitAlarmsData]
    FOR INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT  INTO [dbo].[int_print_job_et_alarm]
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
             [StrLimitFormat],
             [StrValueFormat],
             [ViolatingValue],
             [SettingViolated],
             [RowLastUpdatedOn])
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
        [StrMessage] = [AlarmResources].[StrMessage],
        [StrLimitFormat] = [AlarmResources].[StrLimitFormat],
        [StrValueFormat] = [AlarmResources].[StrValueFormat],
        [ViolatingValue] = [Inserted].[ViolatingValue],
        [SettingViolated] = [Inserted].[SettingViolated],
        [RowLastUpdatedOn] = CAST(GETDATE() AS SMALLDATETIME)
    FROM
        [Inserted]
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
        AND [Inserted].[StatusValue] & 32 = 32;

END;
GO
CREATE TRIGGER [dbo].[trg_Update_Limit_Alarm] ON [dbo].[LimitAlarmsData]
    FOR UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE
        [dbo].[int_print_job_et_alarm]
    SET
        [AlarmEndTimeUTC] = [Inserted].[EndDateTime],
        [RowLastUpdatedOn] = CAST(GETDATE() AS SMALLDATETIME)
    FROM
        [dbo].[int_print_job_et_alarm]
        INNER JOIN [Inserted]
            ON [int_print_job_et_alarm].[AlarmId] = [Inserted].[AlarmId]
    WHERE
        [Inserted].[EndDateTime] IS NOT NULL;
END;
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Contains information about limit alarms for patient topic sessions.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'LimitAlarmsData';

